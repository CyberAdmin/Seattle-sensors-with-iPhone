#import "NodeConnection.h"
#define kPORT 63157  //Change this to your GENI port.
@implementation NodeConnection
@synthesize ip;

/**
 *	Creates a new connection.
 *
 *	@param	ipPassed	IP address of vessel.
 */
-(void)newConnection:(NSString *)ipPassed{
    ip = ipPassed;
    ipPassed = [NSString stringWithFormat:@"%@:%d",ipPassed,kPORT];
    
    NSLog(@"Connecting to: %@", ipPassed);
    
}
-(void)newConnections:(NSArray *)ipsPassed{
    ips = ipsPassed;

    
}
-(void)sendToIPList:(NSString *)data{
    for (NSString *x in ips){
        ip =x;
        [self sendRawData:data];
    }
}

/**
 *	Sends data to a node with passed ip above.
 *
 *	@param	data	Data you wish to send to the specified vessel above.
 */
-(void)sendRawData:(NSString *)data{
 
        //FOR SINGLE IP OF VESSEL ONLY!
    NSLog(@"Connection to this ip --------> %@", ip);
    NSLog(@"Data: %@", data);
    NSString *port = [NSString stringWithFormat:@"%d", kPORT];
    client = [[FastSocket alloc] initWithHost:ip andPort:port];
    bool connected = [client connect];
    if(connected){
        NSLog(@"Connected successfully.");
    }else{
        NSLog(@"Did not connect successfully.");
    }
    [self writeFile:@"data.txt" data:data];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:@"data.txt"];
    NSLog(@"appFile: %@", dataFilePath);
    
    long sent = [client sendFile:dataFilePath];
    NSLog(@"File data sent: %@", [self readFile:dataFilePath]);
    NSLog(@"Data sent: %ld", sent);
    
    char dataRec[1000000];
    long received = [client receiveBytes:dataRec limit:100];
    NSString *maxString = [self findBetween:[NSString stringWithFormat:@"%s", dataRec] first:@"<len>" last:@"</len>"];
    NSLog(@"File size: %@", maxString);
    int maxInt = [maxString intValue];
    char dRec[maxInt];
    long rec = [client receiveBytes:dataRec count:maxInt];  
    NSLog(@"DATAREC: %s", dataRec);

    [client close];
}
-(NSString *)sendRawDataWithResponse:(NSString *)data{
    
    //FOR SINGLE IP OF VESSEL ONLY!
    NSLog(@"Connection to this ip --------> %@", ip);
    NSLog(@"Data: %@", data);
    NSString *port = [NSString stringWithFormat:@"%d", kPORT];
    client = [[FastSocket alloc] initWithHost:ip andPort:port];
    bool connected = [client connect];
    if(connected){
        NSLog(@"Connected successfully.");
    }else{
        NSLog(@"Did not connect successfully.");
    }
    [self writeFile:@"data.txt" data:data];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:@"data.txt"];
    NSLog(@"appFile: %@", dataFilePath);
    
    long sent = [client sendFile:dataFilePath];
    NSLog(@"File data sent: %@", [self readFile:dataFilePath]);
    NSLog(@"Data sent: %ld", sent);
    
    char dataRec[1000000];
    long received = [client receiveBytes:dataRec limit:100];
    NSString *maxString = [self findBetween:[NSString stringWithFormat:@"%s", dataRec] first:@"<len>" last:@"</len>"];
    NSLog(@"File size: %@", maxString);
    int maxInt = [maxString intValue];
    char dRec[maxInt];
    long rec = [client receiveBytes:dataRec count:maxInt]; 
    NSLog(@"DATAREC: %s", dataRec);
    
    [client close];
    return [NSString stringWithFormat:@"%s",dataRec];
    
}
/**
 *	Writes text to file.
 *
 *	@param	fileName	The file path followed by data.txt
 *	@param	data	Data written to file.
 */
-(void)writeFile:(NSString *)fileName data:(NSString *)data

{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSData *sdata = [[NSString stringWithString:data] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:@"data.txt"];
    if(!dataFilePath){ //If file does not exist, create it.
        NSLog(@"File does not exist at this path. Now creating it.");
        [fm createFileAtPath:dataFilePath contents:sdata attributes:nil];
    }else{
        [sdata writeToFile:dataFilePath atomically:YES];
        NSLog(@"Wrote to file. Hope this works.");
    }
    
    //[sdata writeToFile: dataFilePath atomically:YES];
    NSLog(@"File saved at %@ with data %@.", fileName, data);
    
}


/**
 *	Reads data from file.
 *
 *	@param	fileName	File path to read from.
 *
 *	@return	Reads file.
 */
-(NSString *)readFile:(NSString *)fileName

{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSLog(@"{readFile:} filename: %@", appFile);
    
    NSFileManager *fileManager=[NSFileManager defaultManager];

        
    NSError *error= NULL;
        
    id resultData=[NSString stringWithContentsOfFile:appFile encoding:NSUTF8StringEncoding error:&error];
    if (error == NULL){
        return resultData;
            
    }else{
        NSLog(@"%@", [error description]);
    }

    return NULL;
    
}
-(BOOL)success{
    
    return status;
}
-(NSString *)receiveData{
    
    return output;
    
}
/**
 *	Parses text between two delimiters.
 *
 *	@param	message	The text that you want parsed.
 *	@param	begin	First delimeter.
 *	@param	end	Last delimeter.
 *
 *	@return	Value in between the two delimeters.
 */
-(NSString *)findBetween:(NSString *)message first:(NSString *)begin last:(NSString *)end{
    NSString *string = message;
    NSString *result = nil;
    
    NSRange divRange = [string rangeOfString:[NSString stringWithFormat:@"%@", begin] options:NSCaseInsensitiveSearch];
                        if (divRange.location != NSNotFound)
                        {
                            NSRange endDivRange;
                            
                            endDivRange.location = divRange.length + divRange.location;
                            endDivRange.length   = [string length] - endDivRange.location;
                            endDivRange = [string rangeOfString:[NSString stringWithFormat:@"%@", end] options:NSCaseInsensitiveSearch range:endDivRange];
                                           
                                           if (endDivRange.location != NSNotFound)
                                           {
                                               // Tags found: retrieve string between them
                                               divRange.location += divRange.length;
                                               divRange.length = endDivRange.location - divRange.location;
                                               
                                               result = [string substringWithRange:divRange];
                                           }
                        }
    return result;
}
/**
 *	Used in sending raw data from file. This is safer than calling sendRawData with contents of file.
 *
 *	@param	filename	The filename where the file you wish to send is located.
 */
-(void)sendRawDataFromFile:(NSString *)filename{
    NSLog(@"{sendRawDataFromFile: } Filename: %@", filename);
    [self sendRawData:[self readFile:filename]];
}
/**
 *	Append to file. Used if you do not wish to overwrite an existing file.
 *
 *	@param	fileName	A filename. This is stored in the documents directory. (Ex. myData.txt)
 *	@param	data	The data you wish to append to the file.
 */
-(void)appendToFile:(NSString *)fileName data:(NSString *)data{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *logPath = [[NSString alloc] initWithFormat:@"%@",[documentsDir stringByAppendingPathComponent:fileName]];
    NSLog(@"{appendToFile: } logPath: %@", logPath);

    NSFileHandle* fh = [NSFileHandle fileHandleForWritingAtPath:logPath];
    if ( !fh ) {
        [[NSFileManager defaultManager] createFileAtPath:logPath contents:nil attributes:nil];
        fh = [NSFileHandle fileHandleForWritingAtPath:logPath];
    }
    if ( !fh ) NSLog(@"{FH} = NO");
    @try {
        [fh seekToEndOfFile];
        [fh writeData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    }
    @catch (NSException * e) {
        NSLog(@"{EXCEPTION} %@", [e description]);
    }
    [fh closeFile];
    NSLog(@"Appended file.");
}
/**
 *	Deletes file.
 *
 *	@param	fileName	Filename (ex. OBDData.txt)
 */
-(void)deleteFile:(NSString *)fileName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager =[NSFileManager defaultManager];

    [fileManager removeItemAtPath:appFile error:NULL];
    
    NSLog(@"Deleted file at: %@", appFile);
}
@end
