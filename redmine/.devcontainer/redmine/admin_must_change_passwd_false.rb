admin = User.find(1)
admin.must_change_passwd = false
admin.save
