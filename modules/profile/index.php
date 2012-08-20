<?PHP

session_start();


require_once('lib/settings.php');

require_once('controllers/authentication.php');
require_once('controllers/profile.php');
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
		$profile = ProfileController::getUserProfile(AuthenticationController::GetCurrentUserID());
		//$goals = GoalsController::getUserGoals(AuthenticationController::GetCurrentUserID());\
		render('index.html.twig', array('profile'=>$profile));
	}
});

$authenticate = function() use ($app) {
	if(!AuthenticationController::checkLogin()) {
		return redirect('/login');
	}
};

//Profile

$app->get('/profile', function() use ($app){
	if($_GET['method'] == 'create')
	{
		if($_GET['name'] != '' && ProfileController::startNewProfile($_GET['name']))
		{
			$app->flash('header', 'New Profile Successfully Created!');
			return redirect('/');
		}
		else
		{
			if($_GET['name'] == '')
			{
				$app->flash('error', 'Error: Please enter a profile name.');
			}
			else 
			{
				$app->flash('error', 'Error Creating Profile!');
			}
			return redirect('/');
		}
	}
	elseif($_GET['method'] == 'delete')
	{
		$profile = ProfileController::getUserProfile(AuthenticationController::GetCurrentUserID());
		if(ProfileController::removeProfile($profile['profile_id']))
		{
			$app->flash('header', 'Profile Successfully Removed!');
			return redirect('/');
		}
		else
		{
			$app->flash('error', 'Error Removing Profile!');
			return redirect('/');
		}
	}
	else {
		$app->flash('error', 'Method "' . $_GET['method'] . '" Not Supported!');
		return redirect('/');
	}
	
});

require_once('routes/user.php');

$app->run();

?>