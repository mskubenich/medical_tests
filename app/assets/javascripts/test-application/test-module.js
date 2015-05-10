(function(){
    'use strict';
    angular.module('Test', [])
        .controller('TestController', ['$scope', 'questionsFactory', function ($scope, questions) {
            $scope.question_id = null;
            $scope.category_id = $('#state').data('category-id');
            $scope.answered = false;
            $scope.disabled = false;

            $scope.clickAnswerButton = function(){
                $scope.answered = true;
                $scope.answerQuestion();
            };

            $scope.clickNextAnswerButton = function(){
                $scope.answered = false;
                $scope.nextQuestion();
            };

            $scope.clickResetButton = function(){
                $scope.answered = false;
                $scope.answer = {};
                $scope.disabled = true;
                questions.resetGame()
                    .success(function(data){
                        $scope.nextQuestion();
                        $scope.updateState();
                    })
                    .error(function(){
                        $scope.disabled = false;
                    });
            };

            $scope.updateState = function(){
                $scope.disabled = true;
                questions.getGameState()
                    .success(function(data){
                        $scope.state = data;
                        $scope.disabled = false;
                    })
                    .error(function(){
                        $scope.disabled = false;
                    });
            };

            $scope.nextQuestion = function(){
                $scope.disabled = true;
                $scope.correct_answer = null;
                questions.getNextQuestion()
                    .success(function(data){
                        $scope.question = data;

                        $scope.answer = {};
                        var i = 0;
                        while(i < $scope.question.answers.length){
                            $scope.answer[$scope.question.answers[i].id] = false;
                            i++;
                        }
                        $scope.disabled = false;
                    })
                    .error(function(){
                        $scope.disabled = false;
                    });
            };

            $scope.answerQuestion = function(){
                $scope.disabled = true;
                questions.answer({question_id: $scope.question.question.id, answer: $scope.answer})
                    .success(function(data){
                        $scope.correct_answer = data;
                        $scope.updateState();
                        $scope.disabled = false;
                    })
                    .error(function(){
                        $scope.disabled = false;
                    });
            };

            $scope.updateState();
            $scope.nextQuestion();
        }]);

    angular.module('Test')
        .factory('questionsFactory', ['$http', function ($http) {

            var data_el = $('#state');
            var state_category_path = data_el.data('state-category-path');
            var next_question_path = data_el.data('next-question-path');
            var answer_question_path = data_el.data('answer-question-path');
            var reset_path = data_el.data('reset-path');

            return {
                answer: function(data){
                    return $http.post(answer_question_path, data);
                },
                getGameState: function(){
                    return $http.get(state_category_path);
                },
                getNextQuestion: function(){
                    return $http.get(next_question_path);
                },
                resetGame: function(){
                    return $http.post(reset_path);
                }
            };
    }]);
}());