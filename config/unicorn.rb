@app_path = '/'
working_directory "./"
pid "/tmp/unicorn.pid"
listen "/tmp/unicorn.sock"
stderr_path "tmp/log/unicorn.log"
stdout_path "tmp/log/unicornrr.log"


worker_processes 1
preload_app true
timeout 30
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"

  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
  sleep 1
end
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
