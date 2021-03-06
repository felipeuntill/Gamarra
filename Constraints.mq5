
// Summary:
// Bibliotecas importadas
#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>

// Summary:
//
void UpdateConstraints ()
{
   UpdateMarketOpenConstraint();
   UpdateBalanceConstraint();
   UpdateConsecutiveLossesConstraint();
   UpdateMaxDailyLossExcededConstraint();
}


// Summary:
// Verifica se existe alguma restrição de ação no aplicativo, na existência de uma ou mais restrição nenhuma ação de compra deverá ser efetuada.
bool HaveAnActionConstraint ()
{
   bool ShouldNotProceed = false;

   if(!ConstraintMarketOpen){
      //Warn("O PREGÃO AINDA NÃO FOI INICIADO");
      ShouldNotProceed = true;
   }

   if(ConstraintAccountBalanceNegative){
      //Warn("A CONTA ESTÁ NEGATIVA O SISTEMA NÃO POSSUI SALDO PARA EFETUAR NOVAS ORDENS");
      ShouldNotProceed = true;
   }
   
   if(ConstraintExceededMaxConsecutiveLosses){
      //Warn("O SISTEMA EXCEDEU O NUMERO MÁXIMO DE PERDAS CONSECUTIVAS A OPERAÇÃO SÓ SERÁ RESTAURADA NO PROXIMO PREGÃO");
      ShouldNotProceed = true;
   }
   
   if(ConstraintMaxDailyLossExceded){
      //Warn("O SISTEMA EXCEDEU O VALOR LIMITE PARA PARA PERDAS EM UM DIA A OPERAÇÃO SÓ SERÁ RESTAURADA NO PROXIMO PREGÃO");
      ShouldNotProceed = true;
   }

   return ShouldNotProceed;
}

// Summary:
//
void UpdateMarketOpenConstraint ()
{
   datetime _datetime = TimeTradeServer();
   MqlDateTime currentTime;
   TimeToStruct(_datetime,currentTime); 
   
   ConstraintMarketOpen = (currentTime.hour >= OpenHour ) && (currentTime.hour <= CloseHour);
   
   if(ConstraintMarketOpen && currentTime.hour == OpenHour && currentTime.min < OpenMinute)
      ConstraintMarketOpen = false;
      
   if(ConstraintMarketOpen && currentTime.hour == CloseHour && currentTime.min > CloseMinute)
      ConstraintMarketOpen = false;
}

// Summary:
//
void UpdateMaxDailyLossExcededConstraint ()
{
   //if(AccountCurrentBalance < AccountStartingBalance && AccountStartingBalance - AccountCurrentBalance >= MaxDailyLossAmount)
      //ConstraintMaxDailyLossExceded = true;
}


// Summary:
//
void UpdateBalanceConstraint ()
{
   if(AccountCurrentBalance <= 0) 
      ConstraintAccountBalanceNegative = true;
}


// Summary:
//
void UpdateConsecutiveLossesConstraint ()
{
   //if(MaxConsecutiveLosses > 0 && ConsecutiveLosses > MaxConsecutiveLosses) 
      //ConstraintExceededMaxConsecutiveLosses = true;
}