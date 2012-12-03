<?PHP

session_start();


require_once('lib/settings.php');

require_once('controllers/authentication.php');
require_once('controllers/user.php');
require_once('controllers/profile.php');
require_once('controllers/db.php');
require_once('controllers/goals.php');

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
		$user = UserController::getCurrentUserDetails();
		$profile = ProfileController::getCurrentUserProfile();
		$goals = GoalsController::getCurrentUserGoals();

		render('index.html.twig', array('logged_in' => 1, 'user' => $user, 'profile'=>$profile, 'goals' => $goals));
	}
});

$authenticate = function() use ($app) {
	if(!AuthenticationController::checkLogin()) {
		return redirect('/login');
	}
};

//Profile

$app->get('/profile', function() use ($app){
	
	$user = UserController::getCurrentUserDetails();
	$profile = ProfileController::getCurrentUserProfile();
	$devices = ProfileController::getCurrentUserDevices();
	echo "<pre>";
	print_r( $devices);
	echo "</pre>";

	echo constant($devices[0]['type']);

	render('profile.html.twig', array('logged_in' => 1, 'user' => $user, 'profile' => $profile));
/*
	else {
		$app->flash('error', 'Method "' . $_GET['method'] . '" Not Supported!');
		return redirect('/');
	}
*/
	
});


//Goals

$app->post('/goals/details/:id', function($id) use ($app){

	$details = GoalsController::getGoalDetails($id);

	echo json_encode($details);

});


$app->post('/goals/complete/:id', function($id) use ($app){
	return GoalsController::completeInstance($id);
});

require_once('routes/user.php');

$app->run();

?>