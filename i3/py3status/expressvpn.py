# i3status module for ExpressVPN

class Py3status:    
    
    cache_timeout = 0

    def __init__(self):
        self.button = None
        self.connectionStatus = "Disconnected"
        self.VPNstatus = False
        self.up = False
        self.location = ""
        self.status = ""
        self.colour = "#FFFFFF"
    
    def expressvpn(self):
    
        self.up = "Connected" in str(self.py3.command_output("expressvpn status"))

        recommendedLocations = [
            "UK - Docklands",
            "UK - East London",
            "UK - London",
            "Germany - Frankfurt - 1",
            "Netherlands - The Hague",
            "Netherlands - Amsterdam",
            "Netherlands - Rotterdam",
            "USA - New York",
            "USA - Washington DC",
            "USA - New Jersey - 1",
            "USA - Washington DC - 2",
            "France - Paris - 1",
            "Switzerland - 2",
            "Italy - Milan",
            "Italy - Cosenza",
            "Sweden",
            "Spain - Madrid",
            "Belgium"
        ]

        self.location = " (non recommended country)"
                
        if self.VPNstatus:            
            self.VPNstatus = False 
            if self.up:
                self.py3.command_run("expressvpn disconnect")
                self.up = False
            else:
                self.py3.command_run("expressvpn connect")
                self.up = True
        
        self.status = str(self.py3.command_output("expressvpn status"))
        
        for vpnLocation in recommendedLocations:
            if vpnLocation in self.status:
                self.location = f" {vpnLocation.split(' ')[0]}"
        
        if self.up:
            self.connectionStatus = "Connected"
            self.colour = "#FFFFFF"
            if self.button == 1:            
                self.VPNstatus = True
                self.button = None
        else:
            self.connectionStatus = "Not connected"
            self.colour = "#BB3333"
            self.location = ""
            if self.button == 1:            
                self.VPNstatus = True
                self.button = None
            
        if self.location == " (non recommended country)":
            self.colour = "#BB3333"

            
        if "Connecting" in self.status or self.VPNstatus:
            if not self.up:
                self.connectionStatus = "Connecting"
                self.colour = "#888888"
                self.location = ""

        return {
            'full_text': f"{'' if self.up else ''}  VPN:{'' if self.connectionStatus != 'Connecting' else ' Connecting'}{self.location if self.connectionStatus == 'Connected' else ''}{' Off' if self.connectionStatus == 'Not connected' else ''}",
            'cached_until': self.py3.time_in(self.cache_timeout),
            'color': self.colour
        }
        
    def on_click(self, event):
        self.button = event['button']
        


