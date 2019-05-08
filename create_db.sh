# create random password
PASSWDDB="$(openssl rand -base64 12)"

# replace "-" with "_" for database username
echo "Please enter database"
read MAINDB
echo "Please enter new user MySQL!"
read NEWUSER

# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf ]; then
    mysql -e "CREATE USER ${NEWUSER} IDENTIFIED BY '${PASSWDDB}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO ${NEWUSER};"
    mysql -e "FLUSH PRIVILEGES;"

# If /root/.my.cnf doesn't exist then it'll ask for root password
else
    echo "Please enter root user MySQL password!"
    read rootpasswd
    mysql -uroot -p${rootpasswd} -e "CREATE USER ${NEWUSER} IDENTIFIED BY '${PASSWDDB}';"
    mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO ${NEWUSER};"
    mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
fi
echo "Your new password:${PASSWDDB}"

