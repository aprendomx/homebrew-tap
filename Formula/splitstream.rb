# Fórmula generada por deploy/homebrew/render.sh en cada release; no editar en el tap.
class Splitstream < Formula
  desc "Retransmite una señal RTMP de OBS a varias plataformas a la vez"
  homepage "https://github.com/aprendomx/splitstream"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v1.1.0/splitstream-v1.1.0-macos-apple-silicon.tar.gz"
      sha256 "b5eea3722b29006527e5d35ed59f567380a8bafb3b5d89c4d0efa131a24fffcd"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v1.1.0/splitstream-v1.1.0-macos-intel.tar.gz"
      sha256 "82a9451cb8e253c790a56183e2fdea559edd773d1cffb9e0f903bda9e91f3f53"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v1.1.0/splitstream-v1.1.0-linux-arm64.tar.gz"
      sha256 "3b5b9649c55598cc45bae047f7fc9e097cc04e84318126a684acfc174358cbac"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v1.1.0/splitstream-v1.1.0-linux-x86_64.tar.gz"
      sha256 "4e49a885dafdf54072c36c95cfd3fe58b6942d6d452aae721ea4f1d82dbc1a94"
    end
  end

  def install
    bin.install "splitstream"
    doc.install "manual-de-usuario.md" if File.exist?("manual-de-usuario.md")
  end

  # `brew services start splitstream`: la base y la clave en var/splitstream, el log en var/log.
  service do
    run [opt_bin/"splitstream"]
    keep_alive true
    working_dir var/"splitstream"
    environment_variables SPLITSTREAM_DB_PATH: var/"splitstream/splitstream.db"
    log_path var/"log/splitstream.log"
    error_log_path var/"log/splitstream.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/splitstream -version")
  end
end
