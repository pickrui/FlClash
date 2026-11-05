package main

import (
	"errors"
	"slices"
	"strings"
	"unicode/utf8"

	"github.com/metacubex/mihomo/adapter/inbound"
	"github.com/metacubex/mihomo/component/auth"
	"github.com/metacubex/mihomo/config"
	authStore "github.com/metacubex/mihomo/listener/auth"
)

func parseAuthentication(lines []string) ([]auth.AuthUser, error) {
	users := make([]auth.AuthUser, 0, len(lines))
	valid := func(value string) bool {
		return len(value) > 0 && len(value) <= 255 && utf8.ValidString(value) &&
			strings.IndexFunc(value, func(r rune) bool { return r < 32 || r == 127 }) < 0
	}
	for _, line := range lines {
		user, pass, found := strings.Cut(line, ":")
		if !found || !valid(user) || !valid(pass) {
			// Never echo a rejected credential back into UI logs.
			return nil, errors.New("invalid local proxy credentials")
		}
		users = append(users, auth.AuthUser{User: user, Pass: pass})
	}
	return users, nil
}

// Called under runLock after validating the complete patch.
func applyAuthentication(cfg *config.Config, lines []string, users []auth.AuthUser) {
	cfg.General.Authentication = slices.Clone(lines)
	cfg.Users = users
	cfg.General.SkipAuthPrefixes = nil
	inbound.SetSkipAuthPrefixes(nil)
	authStore.Default.SetAuthenticator(auth.NewAuthenticator(users))
}
