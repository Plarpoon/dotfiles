# Enable/Disable the Hetzner 'vpn'
def vpn [] {
    # Define the VPN interface name
    let vpn_interface = 'zcs-sviluppo'

    # Check if the VPN interface is up
    if (ip a | lines | any { |line| $line =~ $vpn_interface }) {
        print "The current state of the VPN is ON."
        let response = (input "Do you want to switch it OFF? (y/n): ")
        if $response in ['y', 'Y'] {
            sudo wg-quick down /etc/wireguard/($vpn_interface).conf
            print "VPN is now OFF."
        } else {
            print "No changes made."
        }
    } else {
        print "The current state of the VPN is OFF."
        let response = (input "Do you want to switch it ON? (y/n): ")
        if $response in ['y', 'Y'] {
            sudo wg-quick up /etc/wireguard/($vpn_interface).conf
            print "VPN is now ON."
        } else {
            print "No changes made."
        }
    }
}
