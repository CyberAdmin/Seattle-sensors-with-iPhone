/*
        MICHAEL REININGER
        ADVISOR: IVAN SESKAR
        RUTGERS WINLAB: SUMMER 2013
        DESCRIPTION: A small library to connect iPhone Apps to Seattle vessels that are running the example comServer.repy program or any other UDP listener program.
        INSTRUCTIONS:
            
            1) Set kPORT in NodeConnection.m to match your Seattle Clearinghouse port (ex. vwxyz)
                #define kPORT vwxyz

            2) In your code's header file (.h), import NodeConnection.h
                #import "NodeConnection.h"

            3) Create a new NodeConnection object in your code's implementation file (.m)
                NodeConnection *connection = [[NodeConnection alloc] init];
 
            4) Set IP address (manually) of the desired node without your specified GENI port (ex. 111.222.333.444)
                [connection newConnection:@"111.222.333.444"];
            
            5) Send data!
                [connection sendRawData:@"Hello, Seattle! This is an iPhone!"];

	YouTube tutorial video available at:
	
 */

#import <Foundation/Foundation.h>
#import "FastSocket.h"

@interface NodeConnection : NSObject{
   
    NSString *ip;  // Stores a single vessel's IP.
    NSArray *ips; // Stores multiple vessels IPs.
    bool status; // Checks the status of the file saved at the vessel on Seattle.
    NSString *output;
    FastSocket *client;
}
@property(nonatomic,retain)NSString *ip;
-(void)newConnection:(NSString *)ipPassed;  //Connect to a single ip.

-(void)newConnections:(NSArray *)ipsPassed;  //Connects to multiple ips.

-(void)sendRawData:(NSString *)data;  //Sends raw bytes to node with the passed data value in NSString.

-(void)writeFile:(NSString *)fileName data:(NSString *)data;  //Used in sendRawData to hold the value.

-(NSString *)readFile:(NSString *)fileName;  //Read data file.

-(BOOL)success;  //Check if message has been sent successfully.

-(void)sendToIPList:(NSString *)data;  //Sends data in NSString to the array of IPs in NSArray *ips;

-(NSString *)receiveData;  //Receives data that is sent over the UDP packet to the Seattle Vessel.

-(NSString *)findBetween:(NSString *)message first:(NSString *)begin last:(NSString *)end; //Make-shift XML parser to find the string between two delimeters.

-(NSString *)sendRawDataWithResponse:(NSString *)data;  //Sends raw data with the expectation of a response.

@end
