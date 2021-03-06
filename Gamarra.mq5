//+------------------------------------------------------------------+
//|                                                      Gamarra.mq5 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

// Summary:
// Bibliotecas importadas
#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>

// Summary:
// Parâmetros de entrada do sistema, os respectivos poderão ser parametrizados através da interface MetaTrader.
input double StopLoss = 5;             //[TRADE] Stop Loss [Pontos] (Operação)
input double TargetPoints = 5;         //[TRADE] Objetivo [Pontos] (Operação)
input int Lot = 2;                     //[TRADE] Lots to Trade (Operação)
//input double MaxDailyLossAmount = 200; //[CONS] Perda Máxima (Por Dia)
input bool SysEnableLogs = false;       //[SYSTEM] Habilitar Log
input ENUM_TIMEFRAMES _PeriodConfirmation = 4;

// Summary:
// Enumeradores
ENUM_MA_METHOD MA_SHORT_METHOD, MA_LONG_METHOD, MA_LONG_METHOD_CONF;

// Summary:
//
double CurrentPrice;


// Summary: 
// Account Properties
double AccountCurrentBalance;
double AccountStartingBalance;

// Summary:
// 
int CloseHour = 17;                                   // Hour to close position
int CloseMinute = 10;                                 // Minute to close the position
int OpenHour = 10;                                    //
int OpenMinute = 5;                                   //

// Summary: 
// Constraints 
bool ConstraintAccountBalanceNegative = false;
bool ConstraintExceededMaxConsecutiveLosses = false;
bool ConstraintMarketOpen = false;
bool ConstraintMaxDailyGainExceded = false;
bool ConstraintMaxDailyLossExceded = false;
bool ConstraintMaxConsecutiveLossesExceded = false;

// Summary:
// Not Grouped Variables
int MA_Period = 3, MA_Period_Slow = 8, MA_Period_Slow_Conf = 8;
int maHandle, maHandleSlow, maHandleSlowConf;
double maVal[], maValSlow[], maValSlowConf[];
int EA_Magic = 12345;      // EA Magic Number
int qtySeriesStored = 3;
MqlTick latest_price;      // To be used for getting recent/latest price quotes
MqlRates mrate[];          // To be used to store the prices, volumes and spread of each bar

int OnInit()
{  
   if(InitializeInfo() != INIT_SUCCEEDED) return INIT_FAILED;
   if(InitializeTradeInfo() != INIT_SUCCEEDED) return INIT_FAILED;
   
   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    IndicatorRelease(maHandle);
    IndicatorRelease(maHandleSlow);  
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   if(Bars(_Symbol, _Period) < 60) return;
   
   //--- Updating Infos
   UpdateTradeInfo();
   
   //--- Updating Properties
   UpdateInfo();
   
   //--- Updating Constraints
   UpdateConstraints();
   
   //--- Taking Actions.
   ExecuteActions();
}

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
  
}

//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
{
//---
   
}
  
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
{
//---
   
}
  
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
{
//---
   double ret=0.0;
//---

//---
   return(ret);
}
  
//+------------------------------------------------------------------+
//| TesterInit function                                              |
//+------------------------------------------------------------------+
void OnTesterInit()
{
//---
   
}
  
//+------------------------------------------------------------------+
//| TesterPass function                                              |
//+------------------------------------------------------------------+
void OnTesterPass()
  {
//---
   
  }
  
//+------------------------------------------------------------------+
//| TesterDeinit function                                            |
//+------------------------------------------------------------------+
void OnTesterDeinit()
  {
//---
   
  }
  
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
//---
   
  }
//+------------------------------------------------------------------+
