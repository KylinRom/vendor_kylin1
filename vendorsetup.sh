for combo in $(cat vendor/kylin/device-list | sed -e 's/#.*$//' | grep kylin | awk {'print $2'})
do
    add_lunch_combo kylin_$combo-userdebug
done
