int Initialize()
{
   maHandle = iMA(_Symbol,_PeriodDefault, MA_Period, 0, MA_SHORT_METHOD, PRICE_CLOSE);
   maHandleSlow = iMA(_Symbol,_PeriodDefault, MA_Period_Slow, 0, MA_SHORT_METHOD,PRICE_CLOSE);
   maHandleSlowConf = iMA(_Symbol, _PeriodConfirmation, MA_Period_Slow_Conf, 0, MA_LONG_METHOD, PRICE_CLOSE); 
   
   if(maHandleSlow < 0 || maHandleSlowConf < 0 || maHandle < 0)
   {
      Error("Error Creating Handles for indicators - error: ", (string)GetLastError(), "!!");
      return(-1);
   }

   Log("Initialização Concluida");
   
   return(INIT_SUCCEEDED);
}