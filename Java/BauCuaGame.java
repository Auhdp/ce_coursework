package Test1;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Random;

public class BauCuaGame extends JFrame implements ActionListener {
    private JLabel resultLabel;
    private JButton spinButton;
    private JButton betButton;
    private JComboBox<String> faceComboBox;
    private JSlider betAmountSlider;
    private int money = 1000;
    private int betAmount = 100;
    private boolean canSpin = false;
    private Random random = new Random();

    public BauCuaGame() {
        setTitle("Bầu Cua Game");
        setSize(400, 250);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        resultLabel = new JLabel("Bạn có " + money + " tiền");
        resultLabel.setHorizontalAlignment(JLabel.CENTER);
        add(resultLabel, BorderLayout.NORTH);

        JPanel controlPanel = new JPanel();
        controlPanel.setLayout(new GridLayout(3, 2));

        JLabel betLabel = new JLabel("Cược:");
        controlPanel.add(betLabel);

        betAmountSlider = new JSlider(JSlider.HORIZONTAL, 100, 500, 100);
        betAmountSlider.setMajorTickSpacing(100);
        betAmountSlider.setPaintTicks(true);
        betAmountSlider.setPaintLabels(true);
        betAmountSlider.addChangeListener(e -> {
            betAmount = betAmountSlider.getValue();
        });
        controlPanel.add(betAmountSlider);

        JLabel faceLabel = new JLabel("Chọn mặt:");
        controlPanel.add(faceLabel);

        String[] faces = {"Bầu", "Cua", "Tôm", "Cá", "Gà", "Nai"};
        faceComboBox = new JComboBox<>(faces);
        controlPanel.add(faceComboBox);

        betButton = new JButton("Đặt cược");
        betButton.addActionListener(this);
        controlPanel.add(betButton);

        spinButton = new JButton("Quay");
        spinButton.addActionListener(this);
        spinButton.setEnabled(false);
        controlPanel.add(spinButton);

        add(controlPanel, BorderLayout.CENTER);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == spinButton && canSpin) {
            money -= betAmount;
            resultLabel.setText("Bạn đã cược " + betAmount + " tiền");

            String selectedFace = (String) faceComboBox.getSelectedItem();
            String[] fruits = {"Bầu", "Cua", "Tôm", "Cá", "Gà", "Nai"};
            String result = "";

            for (int i = 0; i < 3; i++) {
                int randomIndex = random.nextInt(fruits.length);
                result += fruits[randomIndex] + " ";
            }

            resultLabel.setText("Kết quả: " + result);

            if (result.contains(selectedFace)) {
                money += betAmount * 2; // Bạn thắng 2 lần cược
                resultLabel.setText("Kết quả: " + result + " - Bạn thắng " + betAmount * 2 + " tiền");
            } else {
                resultLabel.setText("Kết quả: " + result + " - Bạn đã thua " + betAmount + " tiền");
            }

            resultLabel.setText(resultLabel.getText() + " - Bạn có " + money + " tiền");
            canSpin = false;
            spinButton.setEnabled(false);
        } else if (e.getSource() == betButton) {
            if (money >= betAmount) {
                canSpin = true;
                spinButton.setEnabled(true);
            } else {
                JOptionPane.showMessageDialog(this, "Bạn không đủ tiền cược.", "Thông báo", JOptionPane.WARNING_MESSAGE);
            }
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            BauCuaGame game = new BauCuaGame();
            game.setVisible(true);
        });
    }
}

