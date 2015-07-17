    #import "SalonParser.h"
    #import "SalonData.h"
    #import "SBJSON.h"
    #import "SalonServices.h"
    #import "SalonRoot.h"


    @implementation SalonParser

        NSString* JSON_KEY_SERVICENAME_IPHONEPARSERPARSER=@"serviceName";
        NSString* JSON_KEY_MSG_IPHONEPARSERPARSER=@"msg";
        NSString* JSON_KEY_LONGITUDE_IPHONEPARSERPARSER=@"longitude";
        NSString* JSON_KEY_LATITUDE_IPHONEPARSERPARSER=@"latitude";
        NSString* JSON_KEY_PHONENUMBER_IPHONEPARSERPARSER=@"phoneNumber";
        NSString* JSON_KEY_RESPONSECODE_IPHONEPARSERPARSER=@"responseCode";
        NSString* JSON_KEY_POSTALCODE_IPHONEPARSERPARSER=@"postalCode";
        NSString* JSON_KEY_SALOONADDRESS_IPHONEPARSERPARSER=@"saloonAddress";
        NSString* JSON_KEY_SERVICEID_IPHONEPARSERPARSER=@"serviceID";
        NSString* JSON_KEY_TIMESAT_IPHONEPARSERPARSER=@"timeSat";
        NSString* JSON_KEY_SALOONID_IPHONEPARSERPARSER=@"saloonID";
        NSString* JSON_KEY_DATA_IPHONEPARSERPARSER=@"data";
        NSString* JSON_KEY_TIMESUN_IPHONEPARSERPARSER=@"timeSun";
        NSString* JSON_KEY_SALOONNAME_IPHONEPARSERPARSER=@"saloonName";
        NSString* JSON_KEY_SERVICES_IPHONEPARSERPARSER=@"services";
        NSString* JSON_KEY_TIMEMTOF_IPHONEPARSERPARSER=@"timeMtoF";
        NSString* JSON_KEY_IMAGEPATH_IPHONEPARSERPARSER=@"imagePath";


        +(SalonRoot*) parseSalons:(NSData*) data{
            SalonRoot* root=[[SalonRoot alloc]init];
             if(data)
            {
                SBJSON *jsonParser = [[SBJSON alloc] init];
                NSString* jsonString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
                jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSDictionary *jsonObject = [jsonParser objectWithString:jsonString];
                if(jsonObject)
            {
                
                [root setResponseCode:[SalonParser getString:jsonObject forKey:JSON_KEY_RESPONSECODE_IPHONEPARSERPARSER]];
                [root setData:[SalonParser parseData:[SalonParser getArray:jsonObject forKey:JSON_KEY_DATA_IPHONEPARSERPARSER]]];
                [root setMsg:[SalonParser getString:jsonObject forKey:JSON_KEY_MSG_IPHONEPARSERPARSER]];
                
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
                    [datas addObject:[SalonParser parseDataWithDict:jsonObject]];
                    } @catch(NSException* e){
                    NSLog(@"%@",e);
                    }
                }
            }
            return datas;
        }
        +(SalonData*) parseDataWithDict:(NSDictionary*) jsonObject{
            SalonData* data=[[SalonData alloc]init];
            if(jsonObject)
            {
                
                [data setTimeMtoF:[SalonParser getString:jsonObject forKey:JSON_KEY_TIMEMTOF_IPHONEPARSERPARSER]];
                [data setServices:[SalonParser parseServices:[SalonParser getArray:jsonObject forKey:JSON_KEY_SERVICES_IPHONEPARSERPARSER]]];
                [data setSaloonAddress:[SalonParser getString:jsonObject forKey:JSON_KEY_SALOONADDRESS_IPHONEPARSERPARSER]];
                [data setPostalCode:[SalonParser getString:jsonObject forKey:JSON_KEY_POSTALCODE_IPHONEPARSERPARSER]];
                [data setPhoneNumber:[SalonParser getString:jsonObject forKey:JSON_KEY_PHONENUMBER_IPHONEPARSERPARSER]];
                [data setImagePath:[SalonParser getString:jsonObject forKey:JSON_KEY_IMAGEPATH_IPHONEPARSERPARSER]];
                [data setSaloonName:[SalonParser getString:jsonObject forKey:JSON_KEY_SALOONNAME_IPHONEPARSERPARSER]];
                [data setLongitude:[SalonParser getString:jsonObject forKey:JSON_KEY_LONGITUDE_IPHONEPARSERPARSER]];
                [data setLatitude:[SalonParser getString:jsonObject forKey:JSON_KEY_LATITUDE_IPHONEPARSERPARSER]];
                [data setSaloonID:[SalonParser getString:jsonObject forKey:JSON_KEY_SALOONID_IPHONEPARSERPARSER]];
                [data setTimeSun:[SalonParser getString:jsonObject forKey:JSON_KEY_TIMESUN_IPHONEPARSERPARSER]];
                [data setTimeSat:[SalonParser getString:jsonObject forKey:JSON_KEY_TIMESAT_IPHONEPARSERPARSER]];
                [data setDistance:[SalonParser getString:jsonObject forKey:@"distance"]];
            }
        return data;
        }
        +(NSMutableArray*) parseServices:(NSArray*) jsonArray {
            NSMutableArray* servicess = [[NSMutableArray alloc]init];
            if (jsonArray) {
                for(int i=0;i<jsonArray.count;i++){
                     @try{
                        NSDictionary* jsonObject=[jsonArray objectAtIndex:i];
                    [servicess addObject:[SalonParser parseServicesWithDict:jsonObject]];
                    } @catch(NSException* e){
                    NSLog(@"%@",e);
                    }
                }
            }
            return servicess;
        }
        +(SalonServices*) parseServicesWithDict:(NSDictionary*) jsonObject{
            SalonServices* services=[[SalonServices alloc]init];
            if(jsonObject)
            {
                
                [services setServiceID:[SalonParser getString:jsonObject forKey:JSON_KEY_SERVICEID_IPHONEPARSERPARSER]];
                [services setServiceName:[SalonParser getString:jsonObject forKey:JSON_KEY_SERVICENAME_IPHONEPARSERPARSER]];
                
                
                NSString *isBookable=[SalonParser getString:jsonObject forKey:@"isBookable"];
                
                if(isBookable && [isBookable isEqualToString:@"1"]){
                    [services setIsBookable:YES];
                }else{
                     [services setIsBookable:NO];
                }
                
            }
        return services;
        }

    @end