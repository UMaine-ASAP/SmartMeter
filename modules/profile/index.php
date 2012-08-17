<?PHP

session_start();


require_once('lib/settings.php');

require_once('controllers/authentication.php');
require_once('controllers/db.php');

require_once('lib/helpers.php');
require_once('lib/Slim/Slim.php');
require_once('lib/Views/TwigView.php');

TwigView::$twigDirectory = __DIR__ . '/lib/Twig';

$app = new Slim(array(
	'view' => new TwigView
	));

/**
 *  Render
 * 
 *  Renders the template with given data and global data
 */
function render($templateName, $data, $location='') {
	// Set special global values for every template
	//$userData = UserController::getUserDetails(AuthenticationController::GetCurrentUserID());
	$userData = "pie";

	$GLOBALS['app']->flashNow('location', $location);
	$GLOBALS['app']->flashNow('userData', $userData);
	$GLOBALS['app']->flashNow('web_root', $GLOBALS['web_root']);

	// Render
	$GLOBALS['app']->render($templateName, $data);
}

/** Root Direcotry **/
$app->get('/', function() use ($app) {
	if(!AuthenticationController::checkLogin())
	{
		return redirect('/login');
	}
	else
	{
		render('index.html.twig', array());
	}
});

$authenticate = function() use ($app) {
	if(!AuthenticationController::checkLogin()) {
		return redirect('/login');
	}
};


$app->get('/login', function() use ($app) {
	render('login.html.twig', array());
});

$app->post('/login', function() use ($app){
	if ($_POST['username'] != "" && $_POST['password'] != "" &&
		AuthenticationController::attemptLogin($_POST['username'], $_POST['password']))
	{	// Success!
		return redirect('/');
	}
	else
	{	// Fail :(
		$app->flash('error', 'Username or password was incorrect.');
		return redirect('/login');
	}
});


$app->post('/register', function() use ($app){

	
	if($_POST['username'] == "" || $_POST['password'] == "")
	{
		$app->flash('error', 'All fields are required.');
		return redirect('/login');
	}
	else
	{
		if($hash = AuthenticationController::createHash($_POST['password']))
		{

		    $data = array('username' => $_POST['username'], 'password' => $hash, 'email' => $_POST['email'], 'first' => $_POST['first_name'], 'last' => $_POST['last_name']);
		    $statement = "INSERT INTO AUTH_Users (username, password, first, last, email) VALUES (:username, :password, :first, :last, :email)";

			$result = Database::query($statement, $data);
			if( $result === false) {
				return false;
			}
			return redirect('/');
		}
	}

});
$app->get('/register', function() use ($app) {
	render('register.html.twig', array());
});

$app->run();

?>