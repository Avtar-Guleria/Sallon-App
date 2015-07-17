#import "OfferParser.h"
#import "OfferData.h"
#import "SBJSON.h"
#import "OfferRoot.h"
@implementation OfferParser

	NSString* JSON_KEY_OFFERID_OfferParser=@"offerID";
	NSString* JSON_KEY_MSG_IPHONEPARSERPARSEROffer=@"msg";
	NSString* JSON_KEY_DATA_IPHONEPARSERPARSEROffer=@"data";
	NSString* JSON_KEY_OFFERDESCRIPTION_IPHONEPARSERPARSEROffer=@"offerDescription";
	NSString* JSON_KEY_OFFERNAME_IPHONEPARSERPARSEROffer=@"offerName";
	NSString* JSON_KEY_RESPONSECODE_IPHONEPARSERPARSEROffer=@"responseCode";


	+(OfferRoot*) parseOffers:(NSData*) data{
		OfferRoot* root=[[OfferRoot alloc]init];
		 if(data)
		{
			SBJSON *jsonParser = [[SBJSON alloc] init];
			NSString* jsonString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
			jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			NSDictionary *jsonObject = [jsonParser objectWithString:jsonString];
			if(jsonObject)
		{
			
			[root setResponseCode:[OfferParser getString:jsonObject forKey:JSON_KEY_RESPONSECODE_IPHONEPARSERPARSEROffer]];
			[root setData:[OfferParser parseData:[OfferParser getArray:jsonObject forKey:JSON_KEY_DATA_IPHONEPARSERPARSEROffer]]];
			[root setMsg:[OfferParser getString:jsonObject forKey:JSON_KEY_MSG_IPHONEPARSERPARSEROffer]];
			
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
				[datas addObject:[OfferParser parseDataWithDict:jsonObject]];
				} @catch(NSException* e){
				NSLog(@"%@",e);
				}
			}
		}
		return datas;
	}
	+(OfferData*) parseDataWithDict:(NSDictionary*) jsonObject{
		OfferData* data=[[OfferData alloc]init];
		if(jsonObject)
		{
			
			[data setOfferID:[OfferParser getString:jsonObject forKey:JSON_KEY_OFFERID_OfferParser]];
			[data setOfferDescription:[OfferParser getString:jsonObject forKey:JSON_KEY_OFFERDESCRIPTION_IPHONEPARSERPARSEROffer]];
			[data setOfferName:[OfferParser getString:jsonObject forKey:JSON_KEY_OFFERNAME_IPHONEPARSERPARSEROffer]];
            
            NSString *isSub=[OfferParser getString:jsonObject forKey:@"isSubscribeable"];
            
            if(isSub && [isSub isEqualToString:@"1"]){
                [data setIsSubscribable:YES];
            }else{
                [data setIsSubscribable:NO];
            }
                
			
		}
	return data;
	}
	
@end