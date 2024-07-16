f_domain(physician_fee_freeze, yes).
f_domain(physician_fee_freeze, no). % not in dm rule


f_domain(synfuels_corporation_cutback, yes). % not in dm rule
f_domain(synfuels_corporation_cutback, no).




% Properties for Categorical Features

	% physician_fee_freeze

		% Pre-intervention world
			not_pre_physician_fee_freeze(X) :- f_domain(physician_fee_freeze, Y),pre_physician_fee_freeze(Y), Y \= X.
			pre_physician_fee_freeze(X):- not not_pre_physician_fee_freeze(X).

		% Post-Intervention world
			not_post_physician_fee_freeze(X) :- f_domain(physician_fee_freeze, Y), post_physician_fee_freeze(Y), Y \= X.
			post_physician_fee_freeze(X):- not not_post_physician_fee_freeze(X).


	% synfuels_corporation_cutback

		% Pre-intervention world
			not_pre_synfuels_corporation_cutback(X) :- f_domain(synfuels_corporation_cutback, Y),pre_synfuels_corporation_cutback(Y), Y \= X.
			pre_synfuels_corporation_cutback(X):- not not_pre_synfuels_corporation_cutback(X).

		% Post-Intervention world
			not_post_synfuels_corporation_cutback(X) :- f_domain(synfuels_corporation_cutback, Y), post_synfuels_corporation_cutback(Y), Y \= X.
			post_synfuels_corporation_cutback(X):- not not_post_synfuels_corporation_cutback(X).




% Decision rule to classify if a person makes ’<=50K/yr’
	


	lite_republican(A,B):- A=yes , B=no.
	lite_republican(A,B):- A=yes.

	#show lite_republican/5, not lite_republican/5.
	#show ab1/2, not ab1/2.
	#show ab2/4, not ab2/4.

	republican(A,B):- f_domain(physician_fee_freeze, A),
						f_domain(synfuels_corporation_cutback, B),

						pre_physician_fee_freeze(A), 
						pre_synfuels_corporation_cutback(B),
		
						lite_republican(A,B).


% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	
	cf_republican(A,B):- f_domain(physician_fee_freeze, A),
						f_domain(synfuels_corporation_cutback, B),

						post_physician_fee_freeze(A), 
						post_synfuels_corporation_cutback(B),
		
						not lite_republican(A,B).






% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.

% Measure
	f_domain(control,0).
	f_domain(control,1).


	measure(Z1,Z2,X):- f_domain(control,Z1), f_domain(control,Z2),
		X #= Z1+Z2.


% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

id_restrict(original(A,B),id(Z1,Z2),counterfactual(A1,B1)):- compare_C(A,A1,Z1), compare_C(B,B1,Z2).




% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B):-f_domain(physician_fee_freeze, A),
		f_domain(synfuels_corporation_cutback, B),
		pre_physician_fee_freeze(A), pre_synfuels_corporation_cutback(B).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B):-f_domain(physician_fee_freeze, A),
		f_domain(synfuels_corporation_cutback, B),
		post_physician_fee_freeze(A), post_synfuels_corporation_cutback(B).


% Make the craig function Extremely interpretable
refined(original(A,B),id(Z1,Z2),counterfactual(A1,B1),X):-
	republican(A,B),
	pre_realistic(A,B),

	cf_republican(A1,B1),
	post_realistic(A1,B1),

	id_restrict(original(A,B),id(Z1,Z2),counterfactual(A1,B1)). 
	measure(Z1,Z2,X).



?-republican(A,B).
?-cf_republican(A,B).
?-refined(original(A,B),id(Z1,Z2),counterfactual(A1,B1),X).









