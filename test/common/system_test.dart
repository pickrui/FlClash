import 'package:fl_clash/common/system.dart';
import 'package:test/test.dart';

void main() {
  test('recognizes the Docker runtime marker', () {
    expect(isFlClashDockerEnvironment({'FLCLASH_DOCKER': 'true'}), true);
    expect(isFlClashDockerEnvironment({'FLCLASH_DOCKER': '1'}), true);
    expect(isFlClashDockerEnvironment({'FLCLASH_DOCKER': 'false'}), false);
    expect(isFlClashDockerEnvironment({}), false);
  });
}
