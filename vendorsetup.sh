for combo in `cat vendor/kylin/device-list`
do
    add_lunch_combo kylin_$combo-userdebug
done