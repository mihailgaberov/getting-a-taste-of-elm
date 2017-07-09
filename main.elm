module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main = Html.beginnerProgram { model = model, view = view, update = update }

type alias Model =
    { entries: List String
    , results: List String
    , filter : String
    }

model : Model
model =
    { entries = []
    , results = []
    , filter = ""
    }

type Msg
    = Filter String
    | Add


update : Msg -> Model -> Model
update msg model =
    case msg of
        Filter filter ->
            { model
                | results = List.filter (String.contains filter) model.entries
                , filter = filter
            }
        Add ->
            { model
                | entries = model.filter :: model.entries
                , results = model.filter :: model.results
            }


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Filter...", onInput Filter] []
        , button [ onClick Add ] [ text "Add New"]
        , ul [] (List.map viewEntry model.results)
        ]

viewEntry : String -> Html Msg
viewEntry entry =
    li [] [ text entry ]