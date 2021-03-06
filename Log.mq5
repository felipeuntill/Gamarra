// Summary:
// Bibliotecas importadas
#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>

//+------------------------------------------------------------------+
//| Expert Log function                                              |
//| Summary:                                                         |
//| Efetua log das informações presentes em sistema se o log estiver |
//| habilitado parametro `sysEnableLogs`.                            |
//+------------------------------------------------------------------+
void Log(string param1, string param2 = "", string param3 = "", string param4 = "", string param5 = "", string param6 = "", string param7 = "", string param8 = "", string param9 = "", string param10 = ""){
   if(SysEnableLogs)
      Alert("LOG: ",param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
}  

//+------------------------------------------------------------------+
//| Expert Warn function                                             |
//| Summary:                                                         |
//| Efetua alerta de problemas na execução do aplicativo             |
//+------------------------------------------------------------------+
void Warn(string param1, string param2 = "", string param3 = "", string param4 = "", string param5 = "", string param6 = "", string param7 = "", string param8 = "", string param9 = "", string param10 = ""){
      Alert("AVISO: ",param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
}

//+------------------------------------------------------------------+
//| Expert Error function                                            |
//| Summary:                                                         |
//| Efetua alerta de problemas e erros no projeto                    |
//+------------------------------------------------------------------+
void Error(string param1, string param2 = "", string param3 = "", string param4 = "", string param5 = "", string param6 = "", string param7 = "", string param8 = "", string param9 = "", string param10 = ""){
      Alert("ERRO: ",param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
}