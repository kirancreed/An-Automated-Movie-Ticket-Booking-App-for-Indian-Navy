<?php
include("auth.php");
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navy welfare</title>
    <link rel="icon" type="image/x-icon" href="../../images/favicon.ico">
     <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <?php include("include/css.php"); ?>

<!-- Custom CSS for styling -->
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f0f2f5;
        color: #333;
    }
    .container {
        margin-top: 20px;
    }
    h1, h2 {
        color: #004085;
    }
    .content-wrapper {
        padding: 20px;
    }
    .form-group label {
        font-weight: bold;
    }
    .movie-item {
        margin-bottom: 15px;
    }
    .movie-item label {
        margin-left: 10px;
    }
    .btn-primary {
        background-color: #004085;
        border-color: #004085;
    }
    .btn-primary:hover {
        background-color: #003060;
        border-color: #003060;
    }
    .box {
        margin-top: 20px;
        padding: 20px;
        border: 1px solid #ddd;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .movie-details img {
        width: 100%;
        max-width: 300px;
        border-radius: 5px;
    }
    .animate__animated.animate__fadeIn {
        --animate-duration: 1.5s;
        width: 100%;

    }
    .movie-card {
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        transition: transform 0.3s, box-shadow 0.3s;
        cursor: pointer;
        display: flex;
    flex-direction: column;
    align-items: center; 
        
    }
    .movie-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
    }
    .movie-card img {
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        max-height: 400px;
        object-fit: cover;
        align-self: center;
        
    }
    .movie-card-body {
        padding: 15px;
    }
    .movie-details {
        display: none;
    }



    .add_movie_manually {
    position: static;
    top: 10%;
    right: 0;
    transform: translateY(0) translateX(100%);
    width: 300px;
    padding: 20px;
    background: #41C9E2;
    box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
    border-radius: 10px; /* Apply rounded corners to all sides */
    text-align: left;
    font-family: 'Lucida Console', Monospace;
    color: #333;
    z-index: 1000;
    animation: slideIn 0.5s forwards;
    font-weight: bold;
}

@keyframes slideIn {
    0% {
        transform: translateY(0) translateX(100%);
    }
    100% {
        transform: translateY(0) translateX(0);
    }
}

.add_movie_manually h2 {
    margin-bottom: 10px;
    font-size: 20px;
    color: #444;
}

.add_movie_manually form {
    display: flex;
    flex-direction: column;
}

.add_movie_manually input {
    margin-bottom: 10px;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.add_movie_manually button {
    background-color: #4CAF50;
    color: #fff;
    border: none;
    padding: 10px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.add_movie_manually button:hover {
    background-color: #B3C8CF;
}
.down{
                    outline: 0;
                    grid-gap: 8px;
                    align-items: center;
                    background-color: #ff90e8;
                    color: #000;
                    border: 1px solid #000;
                    border-radius: 4px;
                    cursor: pointer;
                    display: inline-flex;
                    flex-shrink: 0;
                    font-size: 16px;
                    gap: 8px;
                    justify-content: center;
                    line-height: 1.5;
                    overflow: hidden;
                    padding: 12px 16px;
                    text-decoration: none;
                    text-overflow: ellipsis;
                    transition: all .14s ease-out;
                    white-space: nowrap;
                    :hover {
                        box-shadow: 4px 4px 0 #000;
                        transform: translate(-4px,-4px);
                    }
                    :focus-visible{
                        outline-offset: 1px;
                    }
                
}



    @media (min-width: 600px) {
        .containe {
            grid-template-columns: repeat(2, 1fr);
        }
        .responsive-div {
            background-color: white;
        }
    }
    @media (min-width: 900px) {
        .containe {
            grid-template-columns: repeat(3, 1fr);
        }
        .responsive-div {
            background-color: white;
        }
    }


</style>

</head>


<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <header class="main-header">
            <?php include("include/header.php"); ?>
        </header>
        <aside class="main-sidebar">
            <?php include("include/leftmenu.php"); ?>
        </aside>
        <div class="content-wrapper">
            <?php include("include/topmenu.php"); ?>
        </div>

<div class="responsive-div">
    
    <div class="container" >
    <a href="addmovie.php" class="add_movie_manually"  >Add movie manually?</a>
    
        <div class="text-center animate__animated animate__fadeIn" >
            
            <h1>Movie Search</h1>
        </div>

        <!-- Search Form -->
        <form method="GET" action="" class="animate__animated animate__fadeIn">
            <div class="form-group">
                <label for="query">Search for a movie:</label>
                <input type="text" id="query" name="query" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>

        <?php
        if (isset($_GET['query']) && !empty($_GET['query'])) {
            $apiKey = '93f4fbc745ef41fc964d7260b9323a8a';
            $baseUrl = 'https://api.themoviedb.org/3/search/movie';
            $videoBaseUrl = 'https://api.themoviedb.org/3/movie';
            
            $searchQuery = urlencode($_GET['query']);
            $url = "$baseUrl?api_key=$apiKey&query=$searchQuery";

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPGET, true);

            $response = curl_exec($ch);

            if (curl_errno($ch)) {
                echo '<div class="alert alert-danger">cURL error: ' . curl_error($ch) . '</div>';
            } else {
                $searchResults = json_decode($response, true);

                if (isset($searchResults['results']) && count($searchResults['results']) > 0) {
                    echo '<div class="row mt-4 animate__animated animate__fadeIn">';
                    
                    foreach ($searchResults['results'] as $index => $movie) {
                        $movieId = $movie['id'];
                        $title = htmlspecialchars($movie['title']);
                        $posterPath = $movie['poster_path'] ? 'https://image.tmdb.org/t/p/w500' . htmlspecialchars($movie['poster_path']) : 'https://via.placeholder.com/500x750?text=No+Poster';
                        echo '<div class="col-md-4 mb-4">';
                        echo '<div class="movie-card" data-movie-id="' . $movieId . '">';
                        echo '<img src="' . $posterPath . '" alt="' . $title . '">';
                        echo '<div class="movie-card-body">';
                        echo '<label>' . $title . ' (' . htmlspecialchars($movie['release_date']) . ')</label>';
                        echo '</div>';
                        echo '</div>';
                        echo '</div>';
                    }

                    echo '</div>';

                    echo '<div id="movie-details" class="movie-details container mt-5 animate__animated animate__fadeIn">';
                    echo '</div>';
                } else {
                    echo '<div class="alert alert-warning mt-3 animate__animated animate__fadeIn">No results found for your search query.</div>';
                    echo '<div class="text-center animate__animated animate__fadeIn"><a href="addmovie.php" class="btn btn-secondary mt-3">Add movie manually?</a></div>';
                }
            }

            curl_close($ch);
        } else {
            echo '<div class="alert alert-info mt-3 animate__animated animate__fadeIn">Please provide a search query.</div>';
        }
        ?>
    </div>
    </div>

    
    <div class="control-sidebar-bg"></div>
</div>
    </div>
    </div>
<?php include("include/footer.php"); ?>
<?php include("include/js.php"); ?>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const movieCards = document.querySelectorAll('.movie-card');
    movieCards.forEach(card => {
        card.addEventListener('click', function () {
            const movieId = this.getAttribute('data-movie-id');
            fetchMovieDetails(movieId);
        });
    });
});

function fetchMovieDetails(movieId) {
    const apiKey = '93f4fbc745ef41fc964d7260b9323a8a';
    const movieDetailsUrl = `https://api.themoviedb.org/3/movie/${movieId}?api_key=${apiKey}&append_to_response=credits,videos`;

    fetch(movieDetailsUrl)
        .then(response => response.json())
        .then(movieDetails => {
            const detailsContainer = document.getElementById('movie-details');
            detailsContainer.innerHTML = ''; // Clear previous details

            const title = movieDetails.title;
            const releaseDate = movieDetails.release_date;
            const overview = movieDetails.overview;
            const rating = movieDetails.vote_average;
            const posterPath = movieDetails.poster_path ? `https://image.tmdb.org/t/p/w500${movieDetails.poster_path}` : 'https://via.placeholder.com/500x750?text=No+Poster';

            const cast = movieDetails.credits.cast;
            const actorNames = cast.map(actor => actor.name);
            const actorNamesString = actorNames.join(', ');

            let trailerLink = '';
            for (const video of movieDetails.videos.results) {
                if (video.type === 'Trailer' && video.site === 'YouTube') {
                    trailerLink = `https://www.youtube.com/watch?v=${video.key}`;
                    break;
                }
            }

            const detailsHTML = `
                <form method="POST" action="addmovieauto.php">
                    <center><h2>${title}</h2></center>
                    <input type="hidden" name="title" value="${title}">
                    <div class="row">
                        <div class="col-md-4">
                            <img src="${posterPath}" alt="Movie Poster">
                            <input type="hidden" name="image" value="${posterPath}">
                        </div>
                        <div class="col-md-8">
                            <div class="box">
                                <p><strong>Overview:</strong> <textarea class="form-control" name="desc" rows="4">${overview}</textarea></p>
                                <p><strong>Rating:</strong> <input type="text" class="form-control" name="rating" value="${rating}"></p>
                                <p><strong>Cast:</strong> <input type="text" class="form-control" name="cast" value="${actorNamesString}"></p>
                                <input type="hidden" name="trailer" value="${trailerLink}">
                                <p><a href="${trailerLink}" target="_blank" class="btn btn-info">Watch Trailer</a></p>
                                
                            </div>
                            <button type="submit" class="down">Add Movie</button>
                        </div>
                    </div>
                </form>
            `;

            detailsContainer.innerHTML = detailsHTML;
            detailsContainer.style.display = 'block';
            detailsContainer.scrollIntoView({ behavior: 'smooth' });
        })
        .catch(error => {
            console.error('Error fetching movie details:', error);
        });
}
</script>

</body>
</html>
