#import "ServiceParser.h"
#import "ServiceData.h"
#import "SBJSON.h"
#import "ServiceRoot.h"
@implementation ServiceParser

	NSString* JSON_KEY_SERVICENAME_servicePARSER=@"serviceName";
	NSString* JSON_KEY_SERVICEID_servPARSER=@"serviceID";
	NSString* JSON_KEY_MSG_servPARSER=@"msg";
	NSString* JSON_KEY_DATA_servPARSER=@"data";
	NSString* JSON_KEY_RESPONSECODE_servPARSER=@"responseCode";


	+(ServiceRoot*) parseServices:(NSData*) data{
		ServiceRoot* root=[[ServiceRoot alloc]init];
		 if(data)
		{
			SBJSON *jsonParser = [[SBJSON alloc] init];
			NSString* jsonString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
			jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			NSDictionary *jsonObject = [jsonParser objectWithString:jsonString];
			if(jsonObject)
		{
			
			[root setResponseCode:[ServiceParser getString:jsonObject forKey:JSON_KEY_RESPONSECODE_servPARSER]];
			[root setData:[ServiceParser parseData:[ServiceParser getArray:jsonObject forKey:JSON_KEY_DATA_servPARSER]]];
			[root setMsg:[ServiceParser getString:jsonObject forKey:JSON_KEY_MSG_servPARSER]];
			
			}
		}
	return root;
	}
	+(NSMutableArray*) parseData:(NSArray*) jsonArray {
		NSMutableArray* datas = [[NSMutableArray alloc]init];
		if (jsonArray) {
			for(int i=0;i<jsonArray.count;i++){
				 @try{
					NSDictionary* jsonObject=[jsonArray objectAtIndex:i];
				[datas addObject:[ServiceParser parseDataWithDict:jsonObject]];
				} @catch(NSException* e){
				NSLog(@"%@",e);
				}
			}
		}
		return datas;
	}
	+(ServiceData*) parseDataWithDict:(NSDictionary*) jsonObject{
		ServiceData* data=[[ServiceData alloc]init];
		if(jsonObject)
		{
			
			[data setServiceID:[ServiceParser getString:jsonObject forKey:JSON_KEY_SERVICEID_servPARSER]];
			[data setServiceName:[ServiceParser getString:jsonObject forKey:JSON_KEY_SERVICENAME_servicePARSER]];
            
            NSString *isBookable=[ServiceParser getString:jsonObject forKey:@"isBookable"];
            
            if(isBookable && [isBookable isEqualToString:@"1"]){
                [data setIsBookable:YES];
            }else{
                [data setIsBookable:NO];
            }
            

            [data setServiceURL:[ServiceParser getString:jsonObject forKey:@"serviceURL"]];
			
		}
	return data;
	}

@end