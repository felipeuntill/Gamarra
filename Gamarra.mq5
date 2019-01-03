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
//input double StopLoss = 5;             //[TRADE] Stop Loss [Pontos] (Operação)
//input double TargetPoints = 5;         //[TRADE] Objetivo [Pontos] (Operação)
//input int Lot = 2;                     //[TRADE] Lots to Trade (Operação)
//input double MaxDailyLossAmount = 200; //[CONS] Perda Máxima (Por Dia)
input bool SysEnableLogs = false;       //[SYSTEM] Habilitar Log
input ENUM_TIMEFRAMES _PeriodDefault = 5;
input ENUM_TIMEFRAMES _PeriodConfirmation = 4;

// Summary:
// Enumeradores
ENUM_MA_METHOD MA_SHORT_METHOD, MA_LONG_METHOD, MA_LONG_METHOD_CONF;

// Summary:
// Public Variables
int MA_Period = 3, MA_Period_Slow = 8, MA_Period_Slow_Conf = 8;
int maHandle, maHandleSlow, maHandleSlowConf;
double maVal[], maValSlow[], maValSlowConf[];
int EA_Magic = 12345;// EA Magic Number



int OnInit()
{  
   return Initialize();
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

   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
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
