echo "1. Dari Github"
echo "2. Tidak Dari Github"
read -p "mau pilih yang mana ?: " OPSI
if [ $OPSI == 1 ]
then
    read -p "masukan domain: " DOMAIN
    read -p "masukan link github: " LINK
    git clone $LINK /var/www/$DOMAIN/
    echo $DOMAIN
    chown -R $USER:$USER /var/www/$DOMAIN/
    cd /etc/nginx/sites-available/
    echo "
    server {
            listen 80;
            listen [::]:80;
            root /var/www/$DOMAIN/;  
            server_name $DOMAIN www.$DOMAIN;

            location / {
                root /var/www/$DOMAIN/;
                index index.html index.htm;
        }
    }
    " > $DOMAIN
    ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled
    systemctl restart nginx
if [ $OPSI == 2 ]
then
    read -p "masukan domain: " DOMAIN
    echo $DOMAIN
    mkdir /var/ww/$DOMAIN/
    chown -R $USER:$USER /var/www/$DOMAIN/
    cd /var/www/$DOMAIN/
    echo "<html>
    <head>
        <title>Welcome to $DOMAIN</title>
    </head>
    <body>
        <h1>Success! The $DOMAIN server block is working!</h1>
    </body>
    </html>" > index.html
    cd /etc/nginx/sites-available/
    echo "server {
        listen 80;
        listen [::]:80;
        
        root /var/www/$DOMAIN/;
        server_name $DOMAIN www.$DOMAIN;
        
        location / {
            root /var/www/$DOMAIN/;
            index index.html index.htm;
        }
    }
    " > $DOMAIN

    ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled
    systemctl restart nginx
else
    echo "pilihan tidak valid"
fi
