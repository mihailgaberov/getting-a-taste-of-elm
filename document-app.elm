
module DocumentApp exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Navigation
import UrlParser exposing ((</>))

-- MAIN


main : Program Never Model Msg
main =
    Program.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT

type alias Model =
    { currentLocation : Maybe Route
    , documents : List Document
    , currentDocument : Maybe Document
    , newDocument : Maybe String
    }

type alias Document =
    { id : Int
    , title : String
    , content : String
    }

type Route
    = HomeRoute
    | DocumentRoute Int

init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( { currentLocation = UrlParser.parsePath route location
      , documents = []
      , currentDocument = Nothing
      , newDocument = Nothing
      }
    , getDocumentsCmd
    )