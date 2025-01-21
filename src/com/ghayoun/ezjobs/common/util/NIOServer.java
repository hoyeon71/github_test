package com.ghayoun.ezjobs.common.util;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.SocketAddress;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.channels.*;
import java.nio.charset.Charset;
import java.nio.charset.CharsetEncoder;
import java.util.Iterator;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger; 

public class NIOServer implements  Runnable{    
	Selector selector; // 어떤 채널이 어떤 IO 를 할 수 있는지 알려주는 클래스    
	int port = 9999;           
	
	//  한글 전송 ENCODING 설정    
	Charset charset = Charset.forName("EUC-KR");    
	CharsetEncoder encoder = charset.newEncoder();        
	
	public NIOServer() throws IOException {        
		// 1. Selector 생성        selector = Selector.open();                
		// SeverSocket 에 대응하는 ServerSocketChannel 생성        
		ServerSocketChannel channel = ServerSocketChannel.open();                
		
		// 서버 소켓 생성        
		ServerSocket socket = channel.socket();                        
		SocketAddress addr = new InetSocketAddress(port);        
		socket.bind(addr);                        
		
		// Non-Blocking 상태로 만듬        
		channel.configureBlocking(false);                
		
		// 바인딩된 ServerSocketChannel 을 Selector에 등록한다.        
		channel.register(selector, SelectionKey.OP_ACCEPT);                
		
		System.out.println("wait for connecting client");    
	}        
	
	public void run() {        
		
		try {            
			
			int socketOps = SelectionKey.OP_CONNECT | SelectionKey.OP_READ | SelectionKey.OP_WRITE;            
			
			ByteBuffer buffer = null;                        
			
			// 생성된 소켓채널에 대해 accept 상태 일때 알려달라고 selector에 등록 시킨 후            
			// 이벤트가 일어날 때 까지 기다린다.             
			// 클라이언트가 접속하면 Selector는 미리 등록 했던 SeverSocketChannel에 이벤트가            
			// 발생했으므로 Select 메소드에서 1을 돌려준다.            
			
			while(selector.select() > 0) {                
				
				// 현재 Selector에 등록된 채널에 동작이 아니라도 실행 되는 경우 그 채널들을 SelectionKey의               
				// Set 에 추가한다.  아래에서는 선택된 채널들의 키를 얻는다. 즉 해당 IO 에 대해 등록해                 
				// 놓은 채널의 키를 얻는다.                
				
				Set keys = selector.selectedKeys();                
				Iterator iter = keys.iterator();                                                
				
				while(iter.hasNext()) {                    
					SelectionKey selected = (SelectionKey) iter.next();                    
					iter.remove();                                        
					
					// channel() 의 현재 하고 있는 동작(읽기, 쓰기)에 대한 파악                   
					
					SelectableChannel channel = selected.channel();                                     
					
					if(channel instanceof ServerSocketChannel) {                        
						
						// ServerSocketChannel이라면 Accept() 를 호출                       
						// 접속 요청을 해온 상대방 소켓과 연결 될 수 있는 SocketChannel 을 얻는다.                        
						ServerSocketChannel serverSocketChannel = (ServerSocketChannel) channel;                        
						SocketChannel socketChannel = serverSocketChannel.accept();                                                
						
						// 현 시점의 ServerSocketChannel은 Non-Blocking IO로 설정 되어 있음                       
						// 이것은 당장 접속이 없어도 블로킹 되지 않고 바로 NULL 을 던지므로 체크 필요                       
						if(socketChannel == null) {                           

							System.out.println("Socket channel is null");                            
							continue;                        
						}                                                
						
						System.out.println("Client is conntected "+ socketChannel);                        
						
						// 얻은 socketChannel 은 블로킹 소켓이므로 Non-Blocking IO 상태로 설정                       
						socketChannel.configureBlocking(false);                                                
						
						// 소켓 채널을 Selector에 등록                        
						socketChannel.register(selector, socketOps);                    
					} else {                        
						// 일반 소켓 채널이 경우 해당 채널을 얻어 낸다.                        
						SocketChannel socketChannel = (SocketChannel) channel;                        
						
						try {                                                        
							buffer = ByteBuffer.allocate(100);                             
							// 소켓 채널의 행동을 검사해서 그에 대응하는 작업을 함                            
							
							if(selected.isConnectable()) {                                
								System.out.println("Client 와의 연결 설정 OK");                                
								
								if(socketChannel.isConnectionPending()) {                                    
									System.out.println("Client 와의 연결 설정을 마무리 중입니다.");                                    
									
									socketChannel.finishConnect();                                
								}                            
							} else if(selected.isReadable()) {                                
								
								// 읽기 요청 이라면                                
								socketChannel.read(buffer);                                
								
								if(buffer.position() != 0) {                                    
									buffer.clear();                                    
									System.out.println("클라이언트로 전달된 내용:");                                     
									
									// Non-BLocking Mode 이므로 데이터가 모두 전달될때 까지 기다림                                    
									
									while(buffer.hasRemaining()) {                                        
										System.out.print((char)buffer.get());                                    
									}                                    
									
									buffer.clear();                                    
									System.out.println();                                     
									
									// 쓰기가 간단하다면									
									if(selected.isWritable()) {                                        
										String str = "이건 서버에서 보낸 데이터...";
										
										// 한글 인코딩                                        
										CharBuffer charBuf = CharBuffer.wrap(str);
										//ByteBuffer byteBuffer = ByteBuffer.allocate(str.getBytes().length);
										//byteBuffer.put(str.getBytes());
										socketChannel.write(encoder.encode(CharBuffer.wrap(str+"\r\n")));
										
										//socketChannel.write(byteBuffer);
										System.out.println("Send:" + str);                                    
									}                                
								}                             
							}                         
						} catch (Exception ex) {                             
							Logger.getLogger(NIOServer.class.getName()).log(Level.SEVERE, null, ex);                        
						}                    
					}
				}
			}
		} catch (IOException ex) {            
			Logger.getLogger(NIOServer.class.getName()).log(Level.SEVERE, null, ex);                    
		}    
	}        
	
	public static void main(String[] args) throws IOException {        
		NIOServer s = new NIOServer();        
		
		new Thread(s).start();
	}    
}

