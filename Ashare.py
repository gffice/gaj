import json
import requests
import datetime
import pandas as pd

#��Ѷ����
def get_price_day_tx(code, end_date='', count=10, frequency='1d'):     #���߻�ȡ  
    unit='week' if frequency in '1w' else 'month' if frequency in '1M' else 'day'     #�ж����ߣ����ߣ�����
    if end_date:  end_date=end_date.strftime('%Y-%m-%d') if isinstance(end_date,datetime.date) else end_date.split(' ')[0]
    end_date='' if end_date==datetime.datetime.now().strftime('%Y-%m-%d') else end_date   #������ڽ���ͱ�ɿ�    
    URL=f'http://web.ifzq.gtimg.cn/appstock/app/fqkline/get?param={code},{unit},,{end_date},{count},qfq'     
    st= json.loads(requests.get(URL).content);    ms='qfq'+unit;      stk=st['data'][code]   
    buf=stk[ms] if ms in stk else stk[unit]       #ָ�����ز���qfqday,��day
    df=pd.DataFrame(buf,columns=['time','open','close','high','low','volume'],dtype='float')     
    df.time=pd.to_datetime(df.time);    df.set_index(['time'], inplace=True);   df.index.name=''          #�������� 
    return df

#��Ѷ������
def get_price_min_tx(code, end_date=None, count=10, frequency='1d'):    #�����߻�ȡ 
    ts=int(frequency[:-1]) if frequency[:-1].isdigit() else 1           #����K��������
    if end_date: end_date=end_date.strftime('%Y-%m-%d') if isinstance(end_date,datetime.date) else end_date.split(' ')[0]        
    URL=f'http://ifzq.gtimg.cn/appstock/app/kline/mkline?param={code},m{ts},,{count}' 
    st= json.loads(requests.get(URL).content);       buf=st['data'][code]['m'+str(ts)] 
    df=pd.DataFrame(buf,columns=['time','open','close','high','low','volume','n1','n2'])   
    df=df[['time','open','close','high','low','volume']]    
    df[['open','close','high','low','volume']]=df[['open','close','high','low','volume']].astype('float')
    df.time=pd.to_datetime(df.time);   df.set_index(['time'], inplace=True);   df.index.name=''          #��������     
    df['close'][-1]=float(st['data'][code]['qt'][code][3])                #���»���������3λ��
    return df


#sina����ȫ���ڻ�ȡ������������ 5m,15m,30m,60m  ����1d=240m   ����1w=1200m  1��=7200m
def get_price_sina(code, end_date='', count=10, frequency='60m'):    #����ȫ���ڻ�ȡ����    
    frequency=frequency.replace('1d','240m').replace('1w','1200m').replace('1M','7200m');   mcount=count
    ts=int(frequency[:-1]) if frequency[:-1].isdigit() else 1       #����K��������
    if (end_date!='') & (frequency in ['240m','1200m','7200m']): 
        end_date=pd.to_datetime(end_date) if not isinstance(end_date,datetime.date) else end_date    #ת����datetime
        unit=4 if frequency=='1200m' else 29 if frequency=='7200m' else 1    #4,29�༸�����ݲ�Ӱ���ٶ�
        count=count+(datetime.datetime.now()-end_date).days//unit            #����ʱ�䵽�����ж�������Ȼ��(�϶� >������)        
        #print(code,end_date,count)    
    URL=f'http://money.finance.sina.com.cn/quotes_service/api/json_v2.php/CN_MarketData.getKLineData?symbol={code}&scale={ts}&ma=5&datalen={count}' 
    dstr= json.loads(requests.get(URL).content);       
    #df=pd.DataFrame(dstr,columns=['day','open','high','low','close','volume'],dtype='float') 
    df= pd.DataFrame(dstr,columns=['day','open','high','low','close','volume'])
    df['open'] = df['open'].astype(float); df['high'] = df['high'].astype(float);                          #ת����������
    df['low'] = df['low'].astype(float);   df['close'] = df['close'].astype(float);  df['volume'] = df['volume'].astype(float)    
    df.day=pd.to_datetime(df.day);    df.set_index(['day'], inplace=True);     df.index.name=''            #��������                 
    if (end_date!='') & (frequency in ['240m','1200m','7200m']): return df[df.index<=end_date][-mcount:]   #���ߴ�����ʱ���ȷ���              
    return df

def get_price(code, end_date='',count=10, frequency='1d', fields=[]):        #���Ⱪ¶ֻ��Ψһ�������������û��������Ѻõ�  
    xcode= code.replace('.XSHG','').replace('.XSHE','')                      #֤ȯ���������ݴ��� 
    xcode='sh'+xcode if ('XSHG' in code)  else  'sz'+xcode  if ('XSHE' in code)  else code     

    if  frequency in ['1d','1w','1M']:   #1d����  1w����  1M����
         try:    return get_price_sina( xcode, end_date=end_date,count=count,frequency=frequency)   #����
         except: return get_price_day_tx(xcode,end_date=end_date,count=count,frequency=frequency)   #����                    
    
    if  frequency in ['1m','5m','15m','30m','60m']:  #������ ,1mֻ����Ѷ�ӿ�  5����5m   60����60m
         if frequency in '1m': return get_price_min_tx(xcode,end_date=end_date,count=count,frequency=frequency)
         try:    return get_price_sina(  xcode,end_date=end_date,count=count,frequency=frequency)   #����   
         except: return get_price_min_tx(xcode,end_date=end_date,count=count,frequency=frequency)   #����
        
if __name__ == '__main__':    
    df=get_price('sh000001',frequency='1d',count=10)      #֧��'1d'��, '1w'��, '1M'��  
    print('��ָ֤����������\n',df)
    
    df=get_price('000001.XSHG',frequency='15m',count=10)  #֧��'1m','5m','15m','30m','60m'
    print('��ָ֤��������\n',df)

# Ashare ��Ʊ��������( https://github.com/mpquant/Ashare ) 
