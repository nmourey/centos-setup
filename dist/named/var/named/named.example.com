$TTL 3D
@       IN      SOA     ns1.example.com. USER-NAME.example.com. (
					2012052101	; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum


			NS	ns1		; Name Server.
example.com.		MX	10 mail		; Mail Server.

router	A	192.168.0.1			; wireless router

ns1	A	192.168.0.10			; IP Address of DNS Server.
mail	A	192.168.0.11			; IP Mail Server.
