/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data;

/**
 *
 * @author anh
 */

import com.corundumstudio.socketio.SocketIOClient;

public class DataClient {

    public SocketIOClient getClient() {
        return client;
    }

    public void setClient(SocketIOClient client) {
        this.client = client;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public DataClient(SocketIOClient client, String name){
        this.client = client;
        this.name = name;
    }
    
    public DataClient(){
        
    }
    
    SocketIOClient client;
    String name;
    
    public Object[] toRowTable(int row){
        return new Object[]{this, row, name};
    }
}
