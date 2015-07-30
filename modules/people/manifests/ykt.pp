class people::ykt {

  notify { 'class people::ykt declared': }

  # include people::ykt::misc::init
  
  # include people::ykt::admin::console
  # include people::ykt::admin::security
  # include people::ykt::admin::virtual

  # include people::ykt::dev::java
  # include people::ykt::dev::scala
  # include people::ykt::dev::mysql 
  
  # include people::ykt::net::browser
  # include people::ykt::net::chats
  # include people::ykt::misc::editor
  # include people::ykt::misc::productivity

  # include people::ykt::osx::configure

}
