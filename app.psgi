use Plack::Builder;
use Plack::App::File;
use Plack::App::Directory;
use Plack::Middleware::Session;
use Plack::Middleware::Session::Cookie;
use Plack::Session::Store::File;
use lib ('./lib', './local/lib/perl5');
use Wiki;
use WikiApplication;
use UUID::Tiny ':std';

builder {
	# セッション、クッキーの設定をconfig.datから取得
	my $wiki = Wiki->new('setup.dat', $env);
	my $dir = $wiki->config('session_dir', $wiki->config('log_dir'));
	my $limit = $wiki->config('session_limit') || 30;
	my $secret = $wiki->config('secret') || create_uuid(UUID_V4);

    # PSGIを呼び出す前のPlack側の準備
	enable 'Session', store => Plack::Session::Store::File->new(dir => $dir);
	enable 'Session::Cookie', session_key => 'CGISESSID', expires => int($limit) * 60, secret => $secret;
	enable 'CSRFBlock', meta_tag => 'csrf-token';

	# FreeStyleWiki フロントエンドPSGIモジュール
	my WikiApplication $wiki_app = WikiApplication->new;

	# Plack::Middleware::Sessionにセッション情報を設定する
	mount "/fswiki/wiki.cgi" => sub {$wiki_app->run_psgi(@_);};
	mount "/fswiki/theme" => Plack::App::Directory->new({ root => './theme' })->to_app;
	mount "/fswiki/plugin" => Plack::App::Directory->new({ root => './plugin' })->to_app;
};
