<?PHP

$app->get('/login', function() use ($app) {
	render('index.html.twig', array('logged_in' => 0));
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

?>