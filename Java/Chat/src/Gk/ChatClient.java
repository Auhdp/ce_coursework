package Gk;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;

public class ChatClient {
    private Socket socket;
    private PrintWriter writer;
    private JTextArea chatArea;
    private JTextField messageField;

    public ChatClient(String serverAddress, int port) {
        JFrame frame = new JFrame("Chat Client");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);
        frame.setLayout(new BorderLayout());

        chatArea = new JTextArea();
        chatArea.setEditable(false);
        frame.add(new JScrollPane(chatArea), BorderLayout.CENTER);

        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new BorderLayout());
        messageField = new JTextField();
        inputPanel.add(messageField, BorderLayout.CENTER);
        JButton sendButton = new JButton("Send");
        inputPanel.add(sendButton, BorderLayout.EAST);
        frame.add(inputPanel, BorderLayout.SOUTH);

        sendButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String message = messageField.getText();
                sendMessage(message);
                messageField.setText("");
            }
        });

        frame.setVisible(true);

        try {
            socket = new Socket(serverAddress, port);
            writer = new PrintWriter(socket.getOutputStream(), true);
            chatArea.append("Kết nối thành công đến máy chủ.\n");

            // Yêu cầu người dùng nhập tên
            String username = JOptionPane.showInputDialog("Nhập tên người dùng:");
            sendMessage("/username " + username);

            Thread receiveThread = new Thread(new ReceiveMessage());
            receiveThread.start();
        } catch (IOException e) {
            e.printStackTrace();
            chatArea.append("Không thể kết nối đến máy chủ.\n");
        }
    }

    private void sendMessage(String message) {
        if (writer != null) {
            writer.println(message);
        }
    }

    private class ReceiveMessage implements Runnable {
        @Override
        public void run() {
            try {
                BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                String message;

                while ((message = reader.readLine()) != null) {
                    chatArea.append(message + "\n");
                }
            } catch (IOException e) {
                e.printStackTrace();
                chatArea.append("Kết nối bị ngắt.\n");
            }
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                String serverAddress = "localhost";
                String portString = JOptionPane.showInputDialog("Nhập cổng:");
                int port = Integer.parseInt(portString);
                new ChatClient(serverAddress, port);
            }
        });
    }
}
