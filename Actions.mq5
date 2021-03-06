// Summary:
// Bibliotecas importadas
#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>

// Summary:
// Executa os métodos responsáveis pelas tomadas de decisões da aplicação.
void ExecuteActions ()
{


   //---
   //TraillingStop(currentPrice);
   
   //GrantNotBeViolined(currentPrice);
   
   //--
   ClosePositionWhenMarketClosed();
   
   //--
   Buy();
}
 
int Buy()
{
   //---  Checking Constraints to proceeed
   if(!ConstraintMarketOpen && HaveAnActionConstraint()) return ORDER_STATE_REQUEST_CANCEL;

   if(PositionSelect(_Symbol) == true) 
   {
      Warn("JÁ EXISTE UMA OPERAÇÃO EM ANDAMENTO.");
      return ORDER_STATE_REQUEST_CANCEL;
   }

 
//   double diff = maValSlow[0] - maVal[0];
//   double prev_candle_diff = mrate[0].high - mrate[0].low;
//   
//   bool piromba = prev_candle_diff > MaxPiromba;
//   bool spaced = diff >= AvgDiff || diff <= (AvgDiff * -1);
     bool crossingUp = maValSlow[2] > maVal[2] && maValSlow[0] < maVal[0];
   //bool peakIsGood = maValPeak[1] > maVal[1] && maValPeak[0] && maVal[0];
   //bool tendency = (latest_price.ask < mrate[2].high && latest_price.ask < mrate[3].high);
   
   //p_close=mrate[0].close;  // bar 1 close price
   //double p_open = mrate[0].close;
   
   if(crossingUp)// && spaced && !piromba) 
   {        
      double pc = NormalizeDouble(latest_price.ask, _Digits);
      double sl = NormalizeDouble(latest_price.ask - StopLoss,_Digits);
      double tp = NormalizeDouble(latest_price.ask + TargetPoints,_Digits);
      
      return CreateOrder(ORDER_TYPE_BUY, pc, sl, tp);
   }
   
   bool crossingDown = maValSlow[2] < maVal[2] && maValSlow[0] > maVal[0]; 
   
   if(crossingDown)// && spaced && !piromba) 
   {        
      double pc = NormalizeDouble(latest_price.ask, _Digits);
      double sl = NormalizeDouble(latest_price.ask + StopLoss,_Digits);
      double tp = NormalizeDouble(latest_price.ask - TargetPoints,_Digits);
      
      return CreateOrder(ORDER_TYPE_SELL, pc, sl, tp);
   }
   
   return  ORDER_STATE_PLACED;
}


void ClosePositionWhenMarketClosed()
{
   if(!ConstraintMarketOpen && PositionSelect(_Symbol))
   {
      CloseOrders();
   }
}



