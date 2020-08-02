/*
 * RF Initialization app
 */

#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#define TXT_LINE_SIZE 4096
#define RPLY_LINE_SIZE 2048


// https://www.binarytides.com/socket-programming-c-linux-tutorial/

typedef struct {
		int socket_desc_ctrl;
		int socket_desc_data;
		struct sockaddr_in rftool_ctrl;
		struct sockaddr_in rftool_data;
} socketStruct ;

int setupComms(socketStruct *socketInput);

int main()
{
	int status = 0;
	socketStruct rftool_socket;
	char rftool_reply[RPLY_LINE_SIZE];
	FILE* fh = NULL;
	char textbuf[TXT_LINE_SIZE];
    char blank_line[] = "\n";
    char pause_line[] = "PAUSE\n";
	char CONFIG_FILE_LOC[] = "/mnt/hdlcoder_rd/RF_Init.cfg";


    fh = fopen(CONFIG_FILE_LOC,"r");
    if (fh == NULL)
    {
        printf("rf_init: Could not locate %s ! Exiting...\n",CONFIG_FILE_LOC);
        return(0);
    }

	if (setupComms(&rftool_socket) < 0)
	{
			perror("rf_init: Could not connect to RFTOOL. Exiting...");
			return(-1);
	}

    while (!feof(fh))
    {
        fgets(textbuf, sizeof(textbuf), fh);
        int compare2 = strncmp(textbuf, blank_line, 2);
        int compare3 = strcmp(textbuf,pause_line);
        if (compare2==0)
        {
            printf("-----SKIP BLANK LINE-----..\n");

        }
        else if (compare3 == 0)
		{
        	printf("rf_init: PAUSING \n");
			sleep(1);
		}
        else
        {
        	printf("rf_init: SENDING: %s", textbuf);
            if ( send(rftool_socket.socket_desc_ctrl,
						textbuf,
						strlen(textbuf),
						MSG_CONFIRM) < 0 )
            {
            	perror("rf_init: Failed to send command to RFTOOL");
            }

            //look for ack
            status = recv(rftool_socket.socket_desc_ctrl,rftool_reply,RPLY_LINE_SIZE,0);
            if (status < 0)
            {
            	perror("rf_init: Failed to get ack packet from RFTOOL");
            }
            else
            {
            	printf("rf_init: RECEIVED: %.*s \n",status,rftool_reply);
            }
        }

    }
    printf("rf_init: Flushing TCP/IP read buffer...\n");
    status = 1;

    while(status>0)
    {   //empty buffer until we get 0 bytes back (timed out..)
    	status = recv(rftool_socket.socket_desc_ctrl,rftool_reply,2048,0);
    	if (status > 0)
    		printf("rf_init: RECEIVED: %.*s \n",status,rftool_reply);
    }


    fclose(fh);
    printf("rf_init: finished writing to rftool \n");

 return(0);
}

int setupComms(socketStruct *socketInput)
{
		struct timeval tv;
		tv.tv_sec = 2;
		tv.tv_usec = 0;
		int MaxRetry = 20;

		int err = 0;
        //Create socket
		socketInput->socket_desc_ctrl = socket(AF_INET , SOCK_STREAM , 0);
		socketInput->socket_desc_data = socket(AF_INET , SOCK_STREAM , 0);
		if (socketInput->socket_desc_ctrl == -1)
		{
			printf("rf_init: Could not create socket");
		}

		socketInput->rftool_ctrl.sin_addr.s_addr = inet_addr("127.0.0.1");
		socketInput->rftool_ctrl.sin_family = AF_INET;
		socketInput->rftool_ctrl.sin_port = htons( 8081 );



		socketInput->rftool_data.sin_addr.s_addr = inet_addr("127.0.0.1");
		socketInput->rftool_data.sin_family = AF_INET;
		socketInput->rftool_data.sin_port = htons( 8082 );

		//Connect to control plane
		err = -1;
		int connCount = 0;
		while(err<0 && connCount<MaxRetry)
		{

			err = connect(socketInput->socket_desc_ctrl ,
					(struct sockaddr *)&socketInput->rftool_ctrl ,
					sizeof(socketInput->rftool_ctrl));
			sleep(1);
			connCount++;

			if (err<0)
				printf("rf_init: Could not connect to RFTOOL...Iteration:%d \n",connCount);

		}
		if (err<0 && connCount>=MaxRetry)
		{
			printf("rf_init: Failed to establish connection after %d retries \n",connCount);
			return(-1);
		}



		if (connect(socketInput->socket_desc_data , (struct sockaddr *)&socketInput->rftool_data , sizeof(socketInput->rftool_data)) < 0)
		{
			puts("rf_init: Data plane connection error");
			return(-1);
		}
		else
		{
			printf("rf_init: Connected to data plane \n");
		}

		setsockopt(socketInput->socket_desc_ctrl, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv, sizeof tv);
		setsockopt(socketInput->socket_desc_data, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv, sizeof tv);
		return(err);

}




