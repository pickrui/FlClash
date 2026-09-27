import 'package:fl_clash/common/oix_params_storage.dart';
import 'package:fl_clash/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  group('oixCloud plan contract', () {
    test('stable plan identity wins over legacy class', () {
      final plan = StorePlan.fromJson({
        'id': 12,
        'name': 'Pass Alu',
        'class': 9,
        'plan_code': 'alu',
        'plan_rank': 20,
        'node_access': ['edge', 'cia', 'ixp'],
        'default_billing_period': 'quarterly',
        'billing_periods': [
          {
            'key': 'monthly',
            'label': '月付',
            'days': 30,
            'minutes': 43200,
            'price': 10,
            'bandwidth': 100,
            'enabled': true,
          },
          {
            'key': 'quarterly',
            'label': '季付',
            'days': 90,
            'minutes': 129600,
            'price': 27,
            'bandwidth': 280,
            'discount_label': '9折',
            'discount_percent': 10,
            'list_price': 30,
            'savings': 3,
            'enabled': true,
          },
          {
            'key': 'semiannual',
            'label': '半年付',
            'days': 180,
            'minutes': 259200,
            'price': 50,
            'enabled': true,
          },
          {
            'key': 'yearly',
            'label': '年付',
            'days': 365,
            'minutes': 525600,
            'price': 90,
            'enabled': true,
          },
        ],
        'supports_annual': 1,
        'inventory': 3,
      });

      expect(plan.planCode, 'alu');
      expect(plan.planRank, 20);
      expect(plan.enabledBillingPeriods.map((period) => period.key), [
        'monthly',
        'quarterly',
        'semiannual',
        'yearly',
      ]);
      expect(plan.defaultPeriod?.key, 'quarterly');
      expect(plan.defaultPeriod?.price, 27);
      expect(plan.defaultPeriod?.bandwidth, 280);
      expect(plan.defaultPeriod?.discountLabel, '9折');
      expect(plan.supportsAnnual, true);
    });

    test('legacy class is converted only at decode boundary', () {
      final plan = StorePlan.fromJson({
        'id': 2,
        'name': 'Pass Bronze',
        'class': 2,
      });

      expect(plan.planCode, 'alu');
      expect(plan.planRank, 20);
    });

    test('stable code supplies rank before legacy class fallback', () {
      final fromCode = StorePlan.fromJson({
        'id': 1,
        'plan_code': 'bronze',
        'class': 2,
      });
      final explicitZero = StorePlan.fromJson({
        'id': 2,
        'plan_code': 'iron',
        'plan_rank': 0,
        'class': 2,
      });

      expect(fromCode.planCode, 'bronze');
      expect(fromCode.planRank, 30);
      expect(explicitZero.planRank, 0);
    });

    test('legacy special classes keep their old server identity', () {
      final developer = StorePlan.fromJson({'id': 7, 'class': 7});
      final enterprise = StorePlan.fromJson({'id': 9, 'class': 9});
      final realtime = StorePlan.fromJson({'id': 10, 'class': 10});

      expect(developer.planCode, 'developer');
      expect(developer.planRank, 70);
      expect(enterprise.planCode, 'enterprise');
      expect(enterprise.planRank, 90);
      expect(realtime.planCode, 'realtime');
      expect(realtime.planRank, 100);
    });

    test('bought record exposes exact upgrade targets and billing period', () {
      final bought = BoughtRecord.fromJson({
        'id': 8,
        'shop_id': 12,
        'plan_code': 'alu',
        'plan_rank': 20,
        'billing_period': 'quarterly',
        'billing_period_text': '季付',
        'duration_minutes': 129600,
        'upgrade_shop_ids': [20, '21'],
      });

      expect(bought.planRank, 20);
      expect(bought.billingPeriodText, '季付');
      expect(bought.upgradeShopIds, [20, 21]);
    });

    test('bought rank distinguishes explicit zero from missing', () {
      final explicitZero = BoughtRecord.fromJson({
        'id': 1,
        'shop_id': 1,
        'plan_rank': 0,
      });
      final missing = BoughtRecord.fromJson({'id': 2, 'shop_id': 1});

      expect(explicitZero.planRank, 0);
      expect(missing.planRank, isNull);
    });

    test('explicit empty upgrade targets do not use fallback', () {
      final bought = BoughtRecord.fromJson({
        'id': 1,
        'shop_id': 1,
        'plan_rank': 10,
        'upgrade_shop_ids': [],
      });
      final plans = [
        StorePlan.fromJson({
          'id': 1,
          'plan_rank': 10,
          'supports_annual': 1,
          'inventory': 1,
        }),
        StorePlan.fromJson({
          'id': 2,
          'plan_rank': 20,
          'supports_annual': 1,
          'inventory': 1,
        }),
      ];

      expect(storeUpgradeTargets(bought, plans), isEmpty);
    });

    test('upgrade targets prefer server flags and support legacy fallback', () {
      final bought = BoughtRecord.fromJson({
        'id': 1,
        'shop_id': 1,
        'plan_rank': 10,
      });
      final modernPlans = [
        StorePlan.fromJson({
          'id': 1,
          'plan_rank': 10,
          'can_upgrade_to': 0,
          'supports_annual': 1,
          'inventory': 1,
        }),
        StorePlan.fromJson({
          'id': 2,
          'plan_rank': 20,
          'can_upgrade_to': 1,
          'supports_annual': 1,
          'inventory': 1,
        }),
        StorePlan.fromJson({
          'id': 3,
          'plan_rank': 30,
          'can_upgrade_to': 0,
          'supports_annual': 1,
          'inventory': 1,
        }),
      ];
      final legacyPlans = [
        StorePlan.fromJson({
          'id': 1,
          'plan_rank': 10,
          'supports_annual': 1,
          'inventory': 1,
        }),
        StorePlan.fromJson({
          'id': 2,
          'plan_rank': 20,
          'supports_annual': 1,
          'inventory': 1,
        }),
        StorePlan.fromJson({
          'id': 3,
          'plan_rank': 5,
          'supports_annual': 1,
          'inventory': 1,
        }),
      ];

      expect(storeUpgradeTargets(bought, modernPlans).map((plan) => plan.id), [
        2,
      ]);
      expect(storeUpgradeTargets(bought, legacyPlans).map((plan) => plan.id), [
        2,
      ]);
    });

    test('compact summary drops billing period tags', () {
      expect(
        compactStorePlanSummary([
          '流量 2000 GiB',
          '500Mbps 速率',
          '周期 月付 / 季付 / 半年付 / 年付',
          '团队',
        ]),
        '流量 2000 GiB · 500Mbps 速率 · 团队',
      );
    });

    test('store lists skip malformed elements', () {
      final plans = decodeStorePlans([
        {
          'id': 1,
          'billing_periods': [
            {'price': 1, 'enabled': true},
            {'key': 'monthly', 'price': 10, 'enabled': true},
          ],
        },
        false,
        {},
        {'id': 0},
        {'id': '2'},
      ]);
      final bought = decodeBoughtRecords([
        {
          'id': 1,
          'shop_id': 1,
          'upgrade_shop_ids': [1, 'bad', 2, 0],
        },
        null,
        {},
        {'id': 0, 'shop_id': 2},
        {'id': 2, 'shop_id': 0},
        {'id': '3', 'shop_id': '2'},
      ]);

      expect(plans.map((plan) => plan.id), [1, 2]);
      expect(plans.first.billingPeriods.map((period) => period.key), [
        'monthly',
      ]);
      expect(bought.map((record) => record.id), [1, 3]);
      expect(bought.first.upgradeShopIds, [1, 2]);
    });

    test('payment response only renders QR when requested', () {
      final browser = PaymentInitiation.parse({
        'url': 'https://pay.example/order',
        'tradeno': 'browser-order',
      });
      final explicitQr = PaymentInitiation.parse({
        'url': 'https://pay.example/qr',
        'render_qrcode': 1,
      });
      final qrcodeField = PaymentInitiation.parse({
        'url': '',
        'qrcode': 'https://pay.example/qrcode',
      });

      expect(browser.kind, PaymentInitiationKind.externalUrl);
      expect(browser.renderQrcode, false);
      expect(explicitQr.renderQrcode, true);
      expect(qrcodeField.url, 'https://pay.example/qrcode');
      expect(qrcodeField.renderQrcode, true);
    });
  });

  group('oixCloud subscription tier', () {
    test('legacy no-plan display name stays unprivileged', () {
      expect(SubscriptionTier.fromServer('no plan'), SubscriptionTier.none);
    });

    test('editable options keep routing and arbitrary extras', () {
      final params = CloudParams.parse(
        '&mode=emergency&type=love&tfo=false&simplerules=true&area=hk&custom=1',
      );

      expect(
        params.encodeEditableOptions(),
        '&mode=emergency&area=hk&custom=1',
      );
      expect(params.tfo, false);
      expect(params.simplerules, true);
      expect(params.extras, {'area': 'hk', 'custom': '1'});
    });

    test('encoded options round trip without double encoding', () {
      final params = CloudParams.parse(
        '&type=relay&space=a%20b&plus=a+b&ampersand=a%26b',
      );
      final encoded = params.encodeEditableOptions();

      expect(params.extras, {
        'space': 'a b',
        'plus': 'a b',
        'ampersand': 'a&b',
      });
      expect(CloudParams.parse(encoded), params);
      expect(encoded, isNot(contains('%2520')));
      expect(encoded, contains('ampersand=a%26b'));
      expect(encoded, isNot(contains('type=')));
    });

    test('invalid and bare reserved keys never become extras', () {
      final params = CloudParams.parse(
        '&mode=bad&MODE=bad&type=love&type&lv=2&nolv=1&tfo=bad&tfo&simplerules'
        '&provider=clash&age-public-key=x&=orphan&area=hk',
      );

      expect(params.level, isNull);
      expect(params.tfo, isNull);
      expect(params.simplerules, false);
      expect(params.extras, {'area': 'hk'});
      expect(params.encode(), '&area=hk');
      expect(CloudParams.parse('&tfo=true&tfo=bad').tfo, isNull);
    });

    test('mode values are normalized and extras are sorted', () {
      expect(
        CloudParams.parse('?mode=+PREMIUM+&zeta=1&alpha=2').encode(),
        '&mode=premium&alpha=2&zeta=1',
      );
    });

    test('valid mode wins over premium type and invalid repeated mode', () {
      final params = CloudParams.parse(
        '&mode=overseas&type=love&mode=bad&area=hk',
      );

      expect(params.level, NetworkLevel.overseas);
      expect(params.encode(), '&mode=overseas&area=hk');
    });

    test('obsolete type filters are always dropped', () {
      for (final type in [
        'love',
        'latest',
        'extreme',
        'relay',
        'cusrelay',
        'gamer',
        'back',
        'all',
        'default',
      ]) {
        expect(CloudParams.parse('&type=$type').encode(), '');
      }
      expect(CloudParams.parse('&mode=fusion').encode(), '');
    });

    test('obsolete stored default is normalized away', () async {
      SharedPreferences.setMockInitialValues({
        'cloud_service_default_params': '&type=love',
      });

      expect(await CloudParamsStorage.loadDefaultRaw(), '');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('cloud_service_default_params'), '');
    });

    test('tier reconciliation does not overwrite a concurrent save', () async {
      SharedPreferences.setMockInitialValues({
        'cloud_service_config_params': '&mode=emergency&tfo=true',
        'cloud_service_default_params': '&mode=emergency',
      });
      const userParams = CloudParams(
        level: NetworkLevel.overseas,
        tfo: false,
        extras: {'area': 'jp'},
      );

      await Future.wait([
        CloudParamsStorage.reconcileForTier(SubscriptionTier.premium),
        CloudParamsStorage.save(userParams),
      ]);

      expect(await CloudParamsStorage.load(), userParams);
      expect(await CloudParamsStorage.loadDefaultRaw(), '&mode=premium');
    });

    test('tier migration preserves switches and arbitrary extras', () {
      final params = CloudParams.parse(
        '&mode=overseas&tfo=false&simplerules=true&area=hk',
      );
      final migrated = params.applyingTierDefaults(
        SubscriptionTier.premium.defaultParams,
      );

      expect(params.encodeDefaultComparable(), '&mode=overseas');
      expect(migrated.level, NetworkLevel.premium);
      expect(migrated.tfo, false);
      expect(migrated.simplerules, true);
      expect(migrated.extras, {'area': 'hk'});
    });

    test('uses plan rank before display name', () {
      expect(
        SubscriptionTier.fromServer(
          'Pass Bronze',
          planCode: 'iron',
          planRank: 10,
        ),
        SubscriptionTier.none,
      );
      expect(
        SubscriptionTier.fromServer(
          'arbitrary label',
          planCode: 'alu',
          planRank: 20,
        ),
        SubscriptionTier.alu,
      );
      expect(
        SubscriptionTier.fromServer(
          'Pass Iron',
          planCode: 'bronze',
          planRank: 30,
        ),
        SubscriptionTier.alu,
      );

      expect(SubscriptionTier.none.defaultParams.encode(), '');
      expect(SubscriptionTier.alu.defaultParams.encode(), '&mode=emergency');
      expect(SubscriptionTier.premium.defaultParams.encode(), '&mode=premium');
      expect(SubscriptionTier.alu.canSelectEmergency, false);
      expect(SubscriptionTier.premium.canSelectEmergency, true);
      expect(SubscriptionTier.alu.supports(NetworkLevel.emergency), true);
      expect(SubscriptionTier.alu.supports(NetworkLevel.premium), false);
    });

    test('unsupported routing modes return to the tier default', () {
      const params = CloudParams(
        level: NetworkLevel.premium,
        extras: {'area': 'hk'},
      );
      final adjusted = params.adjustedForTier(SubscriptionTier.alu);

      expect(adjusted.level, NetworkLevel.emergency);
      expect(adjusted.extras, {'area': 'hk'});
      expect(
        const CloudParams(
          level: NetworkLevel.emergency,
        ).adjustedForTier(SubscriptionTier.none).level,
        isNull,
      );
      expect(params.adjustedForTier(SubscriptionTier.premium), params);
    });

    test('node access determines routing defaults before plan identity', () {
      expect(
        SubscriptionTier.fromServer(
          'Pass Silver',
          planCode: 'silver',
          planRank: 40,
          nodeAccess: const ['edge', 'cia', 'ixp'],
        ),
        SubscriptionTier.alu,
      );
      expect(
        SubscriptionTier.fromServer(
          'Pass Bronze',
          planCode: 'bronze',
          planRank: 30,
          nodeAccess: const ['edge', 'cia', 'ixp', 'fusion'],
        ),
        SubscriptionTier.premium,
      );
      expect(
        SubscriptionTier.fromServer(
          'Pass Silver',
          planCode: 'silver',
          planRank: 40,
          nodeAccess: const ['edge'],
        ),
        SubscriptionTier.none,
      );
    });

    test('old cached profile defaults new identity fields', () {
      final profile = CloudProfile.fromJson({
        'subscription': 'Pass Bronze',
        'expireTime': '2026-08-01T00:00:00.000Z',
        'todayUsed': '0 B',
        'totalUsed': '0 B',
        'totalTraffic': '1 GB',
        'usageProgress': 0.0,
        'remaining': '1 GB',
        'balance': '0.00',
        'commission': '0.00',
        'points': '0',
      });

      expect(profile.planCode, '');
      expect(profile.planRank, isNull);
      expect(profile.nodeAccess, isEmpty);
      expect(profile.canFetchManagedConfig, false);
      expect(
        SubscriptionTier.fromServer(
          profile.subscription,
          planCode: profile.planCode,
          planRank: profile.planRank,
        ),
        SubscriptionTier.alu,
      );
    });

    test('old Default cache stays unprivileged', () {
      expect(SubscriptionTier.fromServer('Default'), SubscriptionTier.none);
    });

    test('explicit zero rank wins over plan code', () {
      expect(
        SubscriptionTier.fromServer('Pass Iron', planCode: 'iron', planRank: 0),
        SubscriptionTier.none,
      );
    });

    test('managed config requires an active plan with node access', () {
      CloudProfile profile({
        String planCode = 'bronze',
        int? planRank = 30,
        List<String> nodeAccess = const ['edge', 'cia', 'ixp'],
        DateTime? expireTime,
      }) {
        return CloudProfile(
          subscription: 'Pass Bronze',
          planCode: planCode,
          planRank: planRank,
          nodeAccess: nodeAccess,
          expireTime: expireTime ?? DateTime.now().add(const Duration(days: 1)),
          todayUsed: '0 B',
          totalUsed: '0 B',
          totalTraffic: '1 GB',
          usageProgress: 0,
          remaining: '1 GB',
          balance: '0.00',
          commission: '0.00',
          points: '0',
        );
      }

      expect(profile().canFetchManagedConfig, true);
      expect(profile(planCode: 'no_plan').canFetchManagedConfig, false);
      expect(profile(planRank: 0).canFetchManagedConfig, false);
      expect(profile(nodeAccess: const []).canFetchManagedConfig, false);
      expect(
        profile(
          expireTime: DateTime.now().subtract(const Duration(seconds: 1)),
        ).canFetchManagedConfig,
        false,
      );
    });
  });

  group('store display helpers', () {
    test('prices drop whole-yuan decimals and sign refunds', () {
      expect(storePriceText(15), '¥15');
      expect(storePriceText(12.5), '¥12.50');
      expect(storePriceText(-3.2), '-¥3.20');
    });

    test('balances gain one yuan sign', () {
      expect(storeMoneyText('128.50'), '¥128.50');
      expect(storeMoneyText('¥9'), '¥9');
      expect(storeMoneyText(' '), '¥0.00');
      expect(storeMoneyText(null), '¥0.00');
    });

    test('recharge amounts take a comma and at most two decimals', () {
      expect(parseRechargeAmount(' 20 '), 20);
      expect(parseRechargeAmount('12,5'), 12.5);
      expect(parseRechargeAmount('1.234'), isNull);
      expect(parseRechargeAmount('0'), isNull);
      expect(parseRechargeAmount('-5'), isNull);
      expect(parseRechargeAmount('abc'), isNull);
    });

    test('a method without a maximum accepts any amount above its minimum', () {
      const bounded = PaymentMethodOption(
        payment: 'a',
        type: 'a',
        name: '',
        min: 5,
        max: 500,
      );
      const open = PaymentMethodOption(
        payment: 'b',
        type: 'b',
        name: '',
        min: 1,
        max: 0,
      );
      expect(bounded.accepts(5), isTrue);
      expect(bounded.accepts(500.01), isFalse);
      expect(bounded.accepts(4.99), isFalse);
      expect(open.accepts(10000), isTrue);
      expect(open.displayName, 'b');
    });

    test('only a balance shortfall reads as one', () {
      expect(isBalanceShortfallMessage('余额不足，请先充值'), isTrue);
      expect(isBalanceShortfallMessage('Insufficient balance'), isTrue);
      expect(isBalanceShortfallMessage('库存不足'), isFalse);
      expect(isBalanceShortfallMessage('Balance updated'), isFalse);
    });
  });
}
