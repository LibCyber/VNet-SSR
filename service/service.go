package service

import (
	_ "github.com/LibCyber/VNet-SSR/api/client"
	_ "github.com/LibCyber/VNet-SSR/common/log"
	"github.com/LibCyber/VNet-SSR/core"
	_ "os"
)

func Start() (err error) {
	if err = GetSSRManager().Start(); err != nil {
		return err
	}

	if err = GetRuleService().LoadFromApi(); err != nil {
		return err
	}

 	err = core.GetApp().Cron().AddFunc("@monthly", func() {
//		if(!client.HasCertification(core.GetApp().ApiHost())){
//			log.Error("vnet is unauthenticated")
//			os.Exit(0)
//		}
	})
	return err
}

func Reload() error {
	if err := GetSSRManager().Reload(); err != nil {
		return err
	}
	if err := GetRuleService().LoadFromApi(); err != nil {
		return err
	}
	return nil
}
