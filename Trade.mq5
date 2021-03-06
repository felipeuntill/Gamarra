int InitializeTradeInfo()
{
   maHandle = iMA(_Symbol,_Period, MA_Period, 0, MA_SHORT_METHOD, PRICE_CLOSE);
   maHandleSlow = iMA(_Symbol,_Period, MA_Period_Slow, 0, MA_SHORT_METHOD,PRICE_CLOSE);
   maHandleSlowConf = iMA(_Symbol, _PeriodConfirmation, MA_Period_Slow_Conf, 0, MA_LONG_METHOD, PRICE_CLOSE); 
   
   if(maHandleSlow < 0 || maHandleSlowConf < 0 || maHandle < 0)
   {
      Error("Error Creating Handles for indicators - error: ", (string)GetLastError(), "!!");
      return INIT_FAILED;
   }

   Log("Inicialização das Informações de Trade Concluida");
   
   return INIT_SUCCEEDED;
}


void UpdateTradeInfo()
{
   if(!IsNewBar()) return;
   
   UpdateSeries();
   UpdatePrices();
}

void UpdatePrices()
{
   //--- Setting some useful variables.
   double currentPrice = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   
   //--- Get the last price quote using the MQL5 MqlTick Structure
   if(!SymbolInfoTick(_Symbol, latest_price))
   {
      Log("Error getting the latest price quote - error:", (string)GetLastError(), "!!");
      return;
   }

   //--- Get the details of the latest 3 bars
   if(CopyRates(_Symbol, _Period, 0, 10, mrate) < 0)
   {
      Log("Error copying rates/history data - error:", (string)GetLastError(), "!!");
      ResetLastError();
      return;
   }
}

void UpdateSeries()
{
   /*
        Let's make sure our arrays values for the Rates, ADX Values and MA values 
        is store serially similar to the timeseries array
   */
   ArraySetAsSeries(maVal, true);
   ArraySetAsSeries(maValSlow, true);
   ArraySetAsSeries(maValSlowConf, true);
   
   if(CopyBuffer(maHandle, 0, 0, qtySeriesStored, maVal) < 0)
   {
      Error("Erro ao copiar os registros da serie MA Fast:", (string)GetLastError());
      ResetLastError();
      return;
   }
   
   if(CopyBuffer(maHandleSlow, 0, 0, qtySeriesStored, maValSlow) < 0)
   {
      Error("Erro ao copiar os registros da serie MA Slow:", (string)GetLastError());
      ResetLastError();
      return;
   }
   
   if(CopyBuffer(maHandleSlowConf, 0, 0, qtySeriesStored, maValSlowConf) < 0)
   {
      Error("Erro ao copiar os registros da serie MA Slow Conf:", (string)GetLastError());
      ResetLastError();
      return;
   }
}


bool IsNewBar()
{
   // We will use the static Old_Time variable to serve the bar time.
   // At each OnTick execution we will check the current bar time with the saved one.
   // If the bar time isn't equal to the saved time, it indicates that we have a new tick.
   static datetime Old_Time;
   datetime New_Time[1];
   bool IsNewBar=false;
   
   // copying the last bar time to the element New_Time[0]
   int copied = CopyTime(_Symbol,_Period,0,1, New_Time);
   
   if(copied > 0) // ok, the data has been copied successfully
   {
      if(Old_Time != New_Time[0]) // if old time isn't equal to new bar time
      {
         IsNewBar=true;   // if it isn't a first call, the new bar has appeared
         //if(MQL5InfoInteger(MQL5_DEBUGGING)) Print("We have new bar here ",New_Time[0]," old time was ",Old_Time);
         Old_Time=New_Time[0];            // saving bar time
      }
   }
   else
   {
      Error("Error in copying historical times data, error =", (string)GetLastError());
      ResetLastError();
      return false;
   }

   //--- EA should only check for new trade if we have a new bar
   return IsNewBar;
}