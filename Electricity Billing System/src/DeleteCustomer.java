package electricity.billing.system;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class DeleteCustomer extends JFrame implements ActionListener {

    JTextField tfMeterNo;
    JButton delete, cancel;

    DeleteCustomer() {
        setSize(400, 300);
        setLocation(500, 300);
        
        JPanel panel = new JPanel();
        panel.setLayout(null);
        panel.setBackground(new Color(173, 216, 230));
        add(panel);
        
        JLabel heading = new JLabel("Delete Customer");
        heading.setBounds(120, 10, 200, 25);
        heading.setFont(new Font("Tahoma", Font.PLAIN, 24));
        panel.add(heading);
        
        JLabel lblMeterNo = new JLabel("Meter Number");
        lblMeterNo.setBounds(50, 80, 100, 20);
        panel.add(lblMeterNo);
        
        tfMeterNo = new JTextField();
        tfMeterNo.setBounds(180, 80, 150, 20);
        panel.add(tfMeterNo);
        
        delete = new JButton("Delete");
        delete.setBounds(100, 130, 100, 25);
        delete.setBackground(Color.BLACK);
        delete.setForeground(Color.WHITE);
        delete.addActionListener(this);
        panel.add(delete);
        
        cancel = new JButton("Cancel");
        cancel.setBounds(220, 130, 100, 25);
        cancel.setBackground(Color.BLACK);
        cancel.setForeground(Color.WHITE);
        cancel.addActionListener(this);
        panel.add(cancel);
        
        getContentPane().setBackground(Color.WHITE);
        
        setVisible(true);
    }

    public void actionPerformed(ActionEvent ae) {
        if (ae.getSource() == delete) {
            String meterNo = tfMeterNo.getText();
            String query1 = "DELETE FROM customer WHERE meter_no = '" + meterNo + "'";
            String query2 = "DELETE FROM login WHERE meter_no = '" + meterNo + "'";

            try {
                Conn c = new Conn();
                int rowsAffected1 = c.s.executeUpdate(query1);
                int rowsAffected2 = c.s.executeUpdate(query2);

                if (rowsAffected1 > 0 && rowsAffected2 > 0) {
                    JOptionPane.showMessageDialog(null, "Customer Deleted Successfully");
                } else {
                    JOptionPane.showMessageDialog(null, "Customer Not Found");
                }
                setVisible(false);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            setVisible(false);
        }
    }

    public static void main(String[] args) {
        new DeleteCustomer();
    }
}
