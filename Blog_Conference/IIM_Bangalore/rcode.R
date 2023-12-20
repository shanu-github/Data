
#PR Level
#Actual Code
data<-read.csv("C:\\Work\\paper\\Paper_data.csv")
data$Created.on=as.Date(data$Created.on,format="%m/%d/%Y")

data$year<-as.numeric(format(data$Created.on, format = "%Y"))
data$month<-as.numeric(format(data$Created.on, format = "%m")) 

#data preparation for forecasting
forecast_raw_data<-function(data1)
{
  min_date<-min(as.Date(data1$Created.on,format="%m/%d/%Y"))
  max_date<-max(as.Date(data1$Created.on,format="%m/%d/%Y"))
  max_date_day<-as.numeric(format( max_date, format = "%d")) 
  min_date_day<-as.numeric(format( min_date, format = "%d"))
  
  min_month<-as.numeric(format( min_date, format = "%m"))
  min_year<-as.numeric(format( min_date, format = "%Y")) 
  
  #we will not take first month if we have data after 15
  if(min_date_day<15)
  {
        min_date_month<- min_month 
        min_date_year<-min_year
  }else 
    {
      min_date_month<-ifelse(min_month==12,1,min_month+1)
      min_date_year<-ifelse(min_month<12,min_year, min_year+1)
    }
  
  max_month<-as.numeric(format( max_date, format = "%m"))
  max_year<-as.numeric(format( max_date, format = "%Y")) 
  
  #we will not take last month if we have data before 25
  if(max_date_day>25)
    {
      max_date_month<-max_month 
      max_date_year<- max_year
  }else 
    {
      max_date_month<-ifelse(max_month==1,12,max_month-1)
      max_date_year<-ifelse(max_month==1,max_year-1,max_year)
    }
      
  diff<- max_date_year-min_date_year
  order=0
  for(i in 0:diff)
  {
    year1=min_date_year+i
    if(year1==min_date_year) start=min_date_month else start=1
    if(year1==max_date_year) end= max_date_month else end=12
    for(j in start:end)
    {
      temp2<-subset(data1, year==year1 & month==j)
      if(nrow(temp2)>0) quantity=sum(temp2$Order.Quantity) else quantity=0
      order=order+1
      temp<-data.frame(cbind(year1,j,order,quantity))
      if(order==1) final<-temp else final<-rbind(final,temp)
    }
  }
  colnames(final)<-c("year","month","order","quantity")
  return(final)
}

#forecasting model
forecast_model<-function(final)
{
  #material<-"6002.4H2.461"
  #final<-forecast_raw_data(subset(data, Material==material))
  library(forecast)
  #model_1<-HoltWinters(final$quantity, gamma=FALSE)
  model<-auto.arima(final$quantity)
  mase_error<-accuracy(model)[6]
  forecast_1_period<-data.frame(forecast(model, h=1))[1,1]
  predict<- as.data.frame(cbind(forecast_1_period,mase_error))
  return( predict)
}

#for finding conditional probability
conditional_prob<-function(material)
{
  sup_data<-data
  uniue_mat_sup<-data.frame(unique(sup_data[c("Material")]))
  mat_set<-data.frame(unique(data[c("Material", "Created.on")]))
  time_rm_bought<-subset(mat_set, Material==material)
  time_rm_bought<-time_rm_bought[order(time_rm_bought$Created.on),]
  for(i in 1:nrow(uniue_mat_sup))
  {
    temp_mat_data<-subset(mat_set, Material==uniue_mat_sup[i,1])
    for(j in 1:nrow(time_rm_bought))
    {
      col_name<-paste("T",j,sep="")
      if(i==1)
        uniue_mat_sup[,col_name]<-0
      temp_mat_data$diff<-as.numeric(difftime(as.Date(temp_mat_data$Created.on,format="%m/%d/%Y"),as.Date(time_rm_bought$Created.on[j],format="%m/%d/%Y"),units="days")) 
      if(nrow(subset( temp_mat_data,diff>=0 & diff<=15))>0)
        uniue_mat_sup[,col_name][i]<-1
    }
  }
  uniue_mat_sup$Instances<-rowSums(uniue_mat_sup[,2:ncol(uniue_mat_sup)])
  uniue_mat_sup$Prob.<-round(uniue_mat_sup$Instances/nrow(time_rm_bought),2)
  #uniue_mat_sup<-uniue_mat_sup[uniue_mat_sup$Material != material, ]
  return(uniue_mat_sup[c("Material","Prob.","Instances")])
}

#if person is buying mat 1 then what other materials orders can be placed
unique_mat<-data.frame(unique(data[c("Material")]))
unique_mat$Demand_next_month<-NA
unique_mat$MASE_Error<-NA
unique_mat$last_Purchase_date<-NA
unique_mat$last_purchase_quantity<-NA
for(i in 1:nrow(unique_mat))
{
  raw_data<-subset(data,Material==unique_mat[i,1])
  raw_data<-raw_data[order(raw_data$Created.on),]
  forecast_raw_data1<-forecast_raw_data(raw_data)
  f<-forecast_raw_data1[(nrow(forecast_raw_data1)-5):nrow(forecast_raw_data1),]
  unique_mat$Demand_next_month[i]<-NA
  unique_mat$MASE_Error[i]<-NA
  if(nrow(f[f$quantity!=0,])>=3)
  {
  unique_mat$Demand_next_month[i]<-round(forecast_model(forecast_raw_data1)[1,1],2)
  unique_mat$MASE_Error[i]<-round(forecast_model(forecast_raw_data1)[1,2],2)
  }
  unique_mat$last_Purchase_date[i]<-as.character(raw_data[nrow(raw_data),]$Created.on)
  unique_mat$last_purchase_quantity[i]<- raw_data[nrow(raw_data),]$Order.Quantity
  
}

#Give material name which you want to order
material="M9"
cond_result<-conditional_prob(material)
final_order<-merge( unique_mat,cond_result,by=c("Material"))
colnames(final_order)<-c("Material","Next Month Demand","MASE","Last Purchase Date","Last Purchase Quantity","Conditional Prob.","Instances")
write.csv(final_order,"C:\\Work\\paper\\PR_result.csv",row.names = FALSE)

#Buyer Level
#AHP Model 
model_ahp<-function()
{
  library(xlsx)
  rank_data <- read.xlsx("C:\\Work\\paper\\pairwise_ranking.xlsx",sheetIndex=1,rowIndex=NULL)
  rank_data<- rank_data[,-1]
  abc <- as.matrix(rank_data)
  #abc <- matrix(data = 1, nrow = 4, ncol = 4, byrow = TRUE)
  colnames(abc) <- c("Price","Lead time","No of PO's","No of Materials")
  rownames(abc) <- c("Price","Lead time","No of PO's","No of Materials")
  library(pmr)
  output<-ahp(abc)
  e<-as.data.frame(output$weighting)
  rownames(e)<-c("Price","Lead time","No of PO's","No of Materials")
  colnames(e)<-c("Weight")
  return(e)
}

#Ranking of Suppliers
score_calculation<-function(material)
{
  #data1<-data[ which(data$Material=="6002.4H0.031"),] 
  data1<-data[ which(data$Material==material),] 
  #data1<-data_se()
  unique_vendor_name<-as.data.frame(unique(data1[c("Vnd.Mast..Name")]))
  for( i in 1:nrow(unique_vendor_name))
  {
    one_mat_sup_data<- subset(data1,Vnd.Mast..Name== unique_vendor_name[i,1])
    one_mat_sup_data$diff<-abs(difftime(as.Date(one_mat_sup_data$Delivery.Date,format="%m/%d/%Y"),as.Date(one_mat_sup_data$Created.on,format="%m/%d/%Y"),units="days"))
    
    #calculate single price and lead time using mean
    #Price<-mean(one_mat_sup_data$Net.Order.Price)
    #Lead_time<-mean(abs(difftime(as.Date(one_mat_sup_data$Delivery.Date,format="%m/%d/%Y"),as.Date(one_mat_sup_data$Created.on,format="%m/%d/%Y"),units="days")))
    
    #calculate single price and lead time using exponential smoothing
    library(forecast)
    one_mat_sup_data<-one_mat_sup_data[order(as.Date(one_mat_sup_data$Created.on, format="%m/%d/%Y")),]
    Price<-one_mat_sup_data$Net.Order.Price[1]
    Lead_time<-one_mat_sup_data$diff[1]
    if(nrow(one_mat_sup_data)>1)
    {
        fit1 <- HoltWinters(one_mat_sup_data$Net.Order.Price, beta=FALSE, gamma=FALSE)
        Price<-data.frame(forecast(fit1, h=1))[1,1]
        fit2 <- HoltWinters(one_mat_sup_data$diff, beta=FALSE, gamma=FALSE)
        Lead_time<-data.frame(forecast(fit2, h=1))[1,1]
    }
    
    all_mat_sup_data<-subset(data,Vnd.Mast..Name == unique_vendor_name[i,1])
    No_of_PO<-nrow(one_mat_sup_data)
    No_of_mat<-length(unique(all_mat_sup_data$Material))
    vendor_name<- unique_vendor_name[i,1]
    dd1<-as.data.frame(cbind(Price,Lead_time,No_of_PO,No_of_mat))
    dd2<-as.data.frame(cbind(as.character(vendor_name)))
    dd<-cbind(dd2,dd1)
    colnames(dd)<-c("Vendor Name","Price","Lead time","No of PO's","No of Materials")
    if(i==1) supplier_data<-dd else supplier_data<-rbind(supplier_data,dd)
  }
  ##for normalization
  Sup<-supplier_data
  doit <- function(x) {(x)/(max(x,na.rm=TRUE))}
  Sup[,2:ncol(Sup)]<-as.data.frame(lapply(Sup[,2:ncol(Sup)],doit)) 
  
  ##
  Sign_variables<-c(-1,-1,1,1)
  #weight_ahp<-data.frame(c(2,3,4,5))
  weight_ahp<-model_ahp()
  new_weight<-as.data.frame(Sign_variables* weight_ahp)
  supplier_data$Score<-0
  for(i in  1:nrow(supplier_data))
  {
    Score<- as.data.frame(Sup[i,2]*new_weight[1,1]+Sup[i,3]*new_weight[2,1]+Sup[i,4]*new_weight[3,1]+Sup[i,5]*new_weight[4,1])
    supplier_data$Score[i]<-Score[1,1]
  }
  supplier_data <-supplier_data[order(-supplier_data$Score),]
  #supplier_data$Rank<-rank(-supplier_data$Score)
  #supplier_data<-supplier_data[c("Vendor Name","Price","Lead time","No of PO's","No of Materials","Rank")]
  #supplier_data<-supplier_data[c("Vendor Name","Price","Lead time","No of PO's","No of Materials","Rank")]
  return(supplier_data)
}

#best supplier evaluation for all materials
unique_mat<-data.frame(unique(data[c("Material")]))
unique_mat$First_supplier<-"NA"
unique_mat$second_supplier<-"NA"
for(i in 1:nrow(unique_mat))
{
  temp_data<-score_calculation(unique_mat[i,1])
  unique_mat$First_supplier[i]<- as.character(temp_data$`Vendor Name`[1])
  unique_mat$second_supplier[i]<-as.character(temp_data$`Vendor Name`[2])
}


#checking
dd<-forecast_raw_data(subset(data, Material=="F03C.G06.776"))
fore_data<-forecast_model(dd)
h<-conditional_prob("6002.4H0.031")
w<-model_ahp()
s<-score_calculation("M3")


#Material Number extraction for Data Prep.
data<-read.csv("C:\\Work\\I-Buy\\usecase_2\\crib_data_combined.csv")
unique_mat<-data.frame(unique(data$Material))
colnames(unique_mat)<-c("Material")
unique_mat$PR<-0
unique_mat$vendor<-0
for(i in 1:nrow(unique_mat))
{
  
  temp<-subset(data,Material==unique_mat[i,1])
  unique_mat$PR[i]<-nrow(temp)
  unique_mat$vendor[i]<-length(unique(temp$Vnd.Mast..Name))
}

write.csv(unique_mat,"C:\\Work\\I-Buy\\usecase_2\\check1.csv",row.names = FALSE)

