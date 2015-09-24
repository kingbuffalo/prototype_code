package main

import (
    "fmt"
    "net"
	"sync"
	"os"
	"flag"
	"encoding/json"
)

type msgServerCfg struct{
	Port int
    BUnitMsg int
	BWriteLog int
	LogFileName string
}

var strList [1024]string;
var strLen int = 0;
var strListLock sync.RWMutex;
var cfg msgServerCfg

func bInStrList(errLog string)bool{
	strListLock.RLock();
	for i:=0; i<strLen; i++{
		if (strList[i]==errLog ){
			strListLock.RUnlock()
			return true;
		}
	}
	strListLock.RUnlock()
	strListLock.Lock()
	strList[strLen] = errLog
	strLen ++
	if ( strLen >= 1024 ){
		panic("to many err msg:strLen >= 1024")
	}
	strListLock.Unlock()
	return false
}

func handleConnection(conn net.Conn ) {
    bufData := make([]byte,8096)
    if bufLen,err := conn.Read(bufData);err != nil{
        fmt.Println(err)
    }else{
        bufData = bufData[0:bufLen]
    }
    str := string(bufData)
	if cfg.BUnitMsg == 1 {
		if !bInStrList(str) {
			fmt.Println("err nu:",strLen)
			fmt.Println(str)
		}
	}else{
		fmt.Println(str)
	}
	
    conn.Close()
}

func readCfg()([]byte){
    flag.Parse()
    cfgFileName := os.Args[1]
    cfgFile,err := os.Open(cfgFileName)
    if err != nil {
        fmt.Println(err)
        return nil
    }
    defer cfgFile.Close()

    cfgContext := make([]byte,1024000)
    if n,err := cfgFile.Read(cfgContext);err == nil{
        cfgContext = cfgContext[0:n]
    }else{
        fmt.Println(err)
        return nil
    }
    return cfgContext
}

func main() {
	cfgContext := readCfg()
    jerr := json.Unmarshal(cfgContext,&cfg)
	if jerr != nil {
		panic(jerr);
    }
	ipStr := fmt.Sprintf(":%d",cfg.Port)
    ln, err := net.Listen("tcp", ipStr)
	if err != nil {
		panic(err);
    }
    fmt.Println("Listening...")

    for {
        conn, err := ln.Accept()
        if err != nil {
			panic(err);
        }
        go handleConnection(conn)
    }
}

