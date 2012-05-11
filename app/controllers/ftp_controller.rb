require 'net/ftp'

class FtpController < ApplicationController
  def upload
    file = params[:file]
    ftp = Net::FTP.new(params[:ftpserver])
    ftp.passive = true
    ftp.login(user = params[:login], passwd = params[:passwd])
    # ftp.putbinaryfile(file.read, File.basename(file.original_filename))
    ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)
    ftp.quit()
  end

  def index
  end

end
