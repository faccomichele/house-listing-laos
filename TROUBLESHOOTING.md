docker exec -it db mariadb --user root -proot-password

    SHOW databases;

    SELECT User FROM mysql.global_priv;

    SELECT GRANTEE 
    FROM INFORMATION_SCHEMA.USER_PRIVILEGES 
    GROUP BY GRANTEE;

    