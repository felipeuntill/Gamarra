// Sumary:
//
int InitializeInfo ()
{
   AccountCurrentBalance = NormalizeDouble(AccountInfoDouble(ACCOUNT_BALANCE), _Digits);
   AccountStartingBalance = NormalizeDouble(AccountInfoDouble(ACCOUNT_BALANCE), _Digits);
   
   Log("Inicializando as variáveis globais e parametros da aplicação");
   Log("Montate Disponível para Trade", (string)AccountCurrentBalance);
   
   return INIT_SUCCEEDED;
}    
  
//Summary: 
//  
void UpdateInfo ()
{
   AccountCurrentBalance = NormalizeDouble(AccountInfoDouble(ACCOUNT_BALANCE), _Digits);
}
//+------------------------------------------------------------------+
//| Expert ResetPositionIfMarketIsClosed function                    |
//| Summary:                                                         |
//|                                                                  |
//+------------------------------------------------------------------+
void ResetInfo()
{
   if(ConstraintMarketOpen) return;
   
   ConstraintMaxDailyLossExceded = false;
   ConstraintMaxDailyGainExceded = false;
   
   AccountStartingBalance = NormalizeDouble(AccountInfoDouble(ACCOUNT_BALANCE), _Digits);
   AccountCurrentBalance = NormalizeDouble(AccountInfoDouble(ACCOUNT_BALANCE), _Digits);
   
   Log("RESETANDO VARIÁVEIS E CONSTRAINTS PARA O INICIO DE UM NOVO PREGAO");
}