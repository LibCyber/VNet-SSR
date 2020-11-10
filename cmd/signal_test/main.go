package main

import "github.com/LibCyber/VNet-SSR/utils/osx"

func main(){
	println("start...")
	println(osx.WaitSignal().String())
}
