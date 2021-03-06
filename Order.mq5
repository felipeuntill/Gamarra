

int CreateOrder(ENUM_ORDER_TYPE type, double price, double stop, double profit)
{
   MqlTradeRequest mrequest;
   MqlTradeResult mresult;

   ZeroMemory(mrequest);
   ZeroMemory(mresult);
            
   mrequest.action = TRADE_ACTION_DEAL;                // immediate order execution
   mrequest.price = NormalizeDouble(price, _Digits);   // latest ask price //era ask
   mrequest.sl = NormalizeDouble(stop, _Digits);       // Stop Loss //era ask
   mrequest.tp = NormalizeDouble(profit, _Digits);     // Take Profit
   mrequest.symbol = _Symbol;                          // currency pair
   mrequest.volume = Lot;                              // number of lots to trade
   mrequest.magic = EA_Magic;                          // Order Magic Number
   mrequest.type = type;                               // Buy Order Or Sell
   mrequest.type_filling = ORDER_FILLING_RETURN;       // ORDER_FILLING_FOK; // Order execution type
   mrequest.deviation = 100;                           // Deviation from current price
   
   OrderSend(mrequest, mresult);
   
   if(mresult.retcode==10009 || mresult.retcode==10008) //Request is completed or order placed
   {
      //ViolinSafe = false;
      Alert("A Buy order has been successfully placed with Ticket#:", mresult.order, "!!");
      
   }
   else
   {
      Alert("The Buy order request could not be completed -error:",GetLastError());
      Alert("RETCODE =>", mresult.retcode," PRICE =>",  mrequest.price, " Stop =>", mrequest.sl);
      ResetLastError();           
      return ORDER_STATE_CANCELED;
   }
   
   return ORDER_STATE_PLACED;
}

//+------------------------------------------------------------------+
//| Expert CloseOrders function                                      |
//| Summary:                                                         |
//| Finaliza as posições para o ativo selecionado                    |
//+------------------------------------------------------------------+
void CloseOrders()
{
   CTrade trade;
   ulong positionTicket;
   for(int x =  PositionsTotal() -1; x>=0; x--)
   {
      string symbol = PositionGetSymbol(x);
      if(_Symbol == symbol)
      {   
         positionTicket = PositionGetInteger(POSITION_TICKET);
         trade.PositionClose(positionTicket);
      }         
   }
}


void TraillingStop(double current_price)
{
   CTrade trade;
   ulong positionTicket = 0;
   double openPrice= 0;
   double posStop = 0;
   double tralingStop = 3;
   double traiingAfter = 3;
      
   for(int x =  PositionsTotal() -1; x>=0; x--)
   {
      string symbol = PositionGetSymbol(x);
         
      if(_Symbol != symbol) return;
      
      positionTicket = PositionGetInteger(POSITION_TICKET);
      openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      posStop= PositionGetDouble(POSITION_SL);
      
         
      if(current_price > openPrice)
      {
         double trailer = posStop + traiingAfter;
         double newStop = posStop + tralingStop;
         
         if(current_price >= trailer)
         {
              // trade  the partial lot
              Log("TRAILLING STOP => Valor Atual:", (string)current_price, ", Stop Anterior:", (string)posStop, ", Novo Stop:", (string)newStop);
              trade.PositionModify(positionTicket, newStop, 0);
         }
      }        
   }    
}

void GrantNotBeViolined(double currentPrice)
{  
//   if(ViolinSafe) return;
//
//   CTrade trade;
//   double ticket;
//   double op;
//   double tp;
//   double p;
//   double ntp;
//   bool buy;
//   
//   for(int x =  PositionsTotal() -1; x>=0; x--)
//   {
//      if(_Symbol == PositionGetSymbol(x))
//      {
//         buy = PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY;
//         ticket = PositionGetInteger(POSITION_TICKET);
//         op = PositionGetDouble(POSITION_PRICE_OPEN);
//         tp = PositionGetDouble(POSITION_TP);
//         p = buy ? (currentPrice - op) : ((currentPrice*-1) + op);
//         
//         if(p > ViolinSec)
//         {
//            ntp = buy ? (op + 1) : (op - 1);
//            trade.PositionModify(ticket, ntp, tp);
//            ViolinSafe = true;
//            Warn("CONFIGURANDO O BREAKEVEN: ", ntp);
//         }
//      }
//   }
}