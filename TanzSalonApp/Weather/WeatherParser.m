#import "WeatherParser.h"
#import "SBJSON.h"
#import "Weather.h"
#import "Clouds.h"
#import "Rain.h"
#import "Sys.h"
#import "Wind.h"
#import "Coord.h"
#import "WeatherRoot.h"
#import "Main.h"
@implementation WeatherParser

	NSString* JSON_KEY_BASE_IPHONEPARSERPARSER=@"base";
	NSString* JSON_KEY_WEATHER_IPHONEPARSERPARSER=@"weather";
	NSString* JSON_KEY_PRESSURE_IPHONEPARSERPARSER=@"pressure";
	NSString* JSON_KEY_COORD_IPHONEPARSERPARSER=@"coord";
	NSString* JSON_KEY_MAIN_IPHONEPARSERPARSER=@"main";
	NSString* JSON_KEY_MESSAGE_IPHONEPARSERPARSER=@"message";
	NSString* JSON_KEY_TEMP_MIN_IPHONEPARSERPARSER=@"temp_min";
	NSString* JSON_KEY_CLOUDS_IPHONEPARSERPARSER=@"clouds";
	NSString* JSON_KEY_DT_IPHONEPARSERPARSER=@"dt";
	NSString* JSON_KEY_SUNSET_IPHONEPARSERPARSER=@"sunset";
	NSString* JSON_KEY_ALL_IPHONEPARSERPARSER=@"all";
	NSString* JSON_KEY_HUMIDITY_IPHONEPARSERPARSER=@"humidity";
	NSString* JSON_KEY_SYS_IPHONEPARSERPARSER=@"sys";
	NSString* JSON_KEY_ID_IPHONEPARSERPARSER=@"id";
	NSString* JSON_KEY_RAIN_IPHONEPARSERPARSER=@"rain";
	NSString* JSON_KEY_SUNRISE_IPHONEPARSERPARSER=@"sunrise";
	NSString* JSON_KEY_WIND_IPHONEPARSERPARSER=@"wind";
	NSString* JSON_KEY_DESCRIPTION_IPHONEPARSERPARSER=@"description";
	NSString* JSON_KEY_SPEED_IPHONEPARSERPARSER=@"speed";
	NSString* JSON_KEY_LON_IPHONEPARSERPARSER=@"lon";
	NSString* JSON_KEY_DEG_IPHONEPARSERPARSER=@"deg";
	NSString* JSON_KEY_COUNTRY_IPHONEPARSERPARSER=@"country";
	NSString* JSON_KEY_NAME_IPHONEPARSERPARSER=@"name";
	NSString* JSON_KEY_LAT_IPHONEPARSERPARSER=@"lat";
	NSString* JSON_KEY_TEMP_MAX_IPHONEPARSERPARSER=@"temp_max";
	NSString* JSON_KEY_TEMP_IPHONEPARSERPARSER=@"temp";
	NSString* JSON_KEY_COD_IPHONEPARSERPARSER=@"cod";
	NSString* JSON_KEY_ICON_IPHONEPARSERPARSER=@"icon";
	NSString* JSON_KEY_3H_IPHONEPARSERPARSER=@"3h";


	+(WeatherRoot*) parseWeatherData:(NSData*) data{
		WeatherRoot* root=[[WeatherRoot alloc]init];
		 if(data)
		{
			SBJSON *jsonParser = [[SBJSON alloc] init];
			NSString* jsonString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
			jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			NSDictionary *jsonObject = [jsonParser objectWithString:jsonString];
			if(jsonObject)
		{
			
			[root setId:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_ID_IPHONEPARSERPARSER]];
			[root setDt:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_DT_IPHONEPARSERPARSER]];
			[root setClouds:[WeatherParser parseClouds:[WeatherParser getDictionary:jsonObject forKey:JSON_KEY_CLOUDS_IPHONEPARSERPARSER]]];
			[root setCoord:[WeatherParser parseCoord:[WeatherParser getDictionary:jsonObject forKey:JSON_KEY_COORD_IPHONEPARSERPARSER]]];
			[root setWind:[WeatherParser parseWind:[WeatherParser getDictionary:jsonObject forKey:JSON_KEY_WIND_IPHONEPARSERPARSER]]];
			[root setCod:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_COD_IPHONEPARSERPARSER]];
			[root setSys:[WeatherParser parseSys:[WeatherParser getDictionary:jsonObject forKey:JSON_KEY_SYS_IPHONEPARSERPARSER]]];
			[root setName:[WeatherParser getString:jsonObject forKey:JSON_KEY_NAME_IPHONEPARSERPARSER]];
			[root setBase:[WeatherParser getString:jsonObject forKey:JSON_KEY_BASE_IPHONEPARSERPARSER]];
			[root setWeather:[WeatherParser parseWeather:[WeatherParser getArray:jsonObject forKey:JSON_KEY_WEATHER_IPHONEPARSERPARSER]]];
			[root setRain:[WeatherParser parseRain:[WeatherParser getDictionary:jsonObject forKey:JSON_KEY_RAIN_IPHONEPARSERPARSER]]];
			[root setMain:[WeatherParser parseMain:[WeatherParser getDictionary:jsonObject forKey:JSON_KEY_MAIN_IPHONEPARSERPARSER]]];
			
			}
		}
	return root;
	}
	+(Clouds*) parseClouds:(NSDictionary*) jsonObject{
		Clouds* clouds=[[Clouds alloc]init];
		if(jsonObject)
		{
			
			[clouds setAll:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_ALL_IPHONEPARSERPARSER]];
			
		}
	return clouds;
	}
	+(Coord*) parseCoord:(NSDictionary*) jsonObject{
		Coord* coord=[[Coord alloc]init];
		if(jsonObject)
		{
			
			[coord setLon:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_LON_IPHONEPARSERPARSER]];
			[coord setLat:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_LAT_IPHONEPARSERPARSER]];
			
		}
	return coord;
	}
	+(Wind*) parseWind:(NSDictionary*) jsonObject{
		Wind* wind=[[Wind alloc]init];
		if(jsonObject)
		{
			
			[wind setSpeed:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_SPEED_IPHONEPARSERPARSER]];
			[wind setDeg:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_DEG_IPHONEPARSERPARSER]];
			
		}
	return wind;
	}
	+(Sys*) parseSys:(NSDictionary*) jsonObject{
		Sys* sys=[[Sys alloc]init];
		if(jsonObject)
		{
			
			[sys setMessage:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_MESSAGE_IPHONEPARSERPARSER]];
			[sys setSunset:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_SUNSET_IPHONEPARSERPARSER]];
			[sys setSunrise:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_SUNRISE_IPHONEPARSERPARSER]];
			[sys setCountry:[WeatherParser getString:jsonObject forKey:JSON_KEY_COUNTRY_IPHONEPARSERPARSER]];
			
		}
	return sys;
	}
	+(Rain*) parseRain:(NSDictionary*) jsonObject{
		Rain* rain=[[Rain alloc]init];
		if(jsonObject)
		{
			
			[rain setThreeh:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_3H_IPHONEPARSERPARSER]];
			
		}
	return rain;
	}
	+(Main*) parseMain:(NSDictionary*) jsonObject{
		Main* main=[[Main alloc]init];
		if(jsonObject)
		{
			
			[main setHumidity:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_HUMIDITY_IPHONEPARSERPARSER]];
			[main setPressure:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_PRESSURE_IPHONEPARSERPARSER]];
			[main setTemp_max:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_TEMP_MAX_IPHONEPARSERPARSER]];
			[main setTemp_min:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_TEMP_MIN_IPHONEPARSERPARSER]];
			[main setTemp:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_TEMP_IPHONEPARSERPARSER]];
			
		}
	return main;
	}
	+(NSMutableArray*) parseWeather:(NSArray*) jsonArray {
		NSMutableArray* weathers = [[NSMutableArray alloc]init];
		if (jsonArray) {
			for(int i=0;i<jsonArray.count;i++){
				 @try{
					NSDictionary* jsonObject=[jsonArray objectAtIndex:i];
				[weathers addObject:[WeatherParser parseWeatherWithDict:jsonObject]];
				} @catch(NSException* e){
				NSLog(@"%@",e);
				}
			}
		}
		return weathers;
	}
	+(Weather*) parseWeatherWithDict:(NSDictionary*) jsonObject{
		Weather* weather=[[Weather alloc]init];
		if(jsonObject)
		{
			
			[weather setId:[WeatherParser getNumber:jsonObject forKey:JSON_KEY_ID_IPHONEPARSERPARSER]];
			[weather setIcon:[WeatherParser getString:jsonObject forKey:JSON_KEY_ICON_IPHONEPARSERPARSER]];
			[weather setDescription:[WeatherParser getString:jsonObject forKey:JSON_KEY_DESCRIPTION_IPHONEPARSERPARSER]];
			[weather setMain:[WeatherParser getString:jsonObject forKey:JSON_KEY_MAIN_IPHONEPARSERPARSER]];
			
		}
	return weather;
	}

@end