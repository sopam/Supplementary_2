f_domain(physician_fee_freeze, yes).
f_domain(physician_fee_freeze, no).

f_domain(budget_resolution, yes).
f_domain(budget_resolution, no).

f_domain(handicapped_infants, yes).
f_domain(handicapped_infants, no).

f_domain(synfuels_corporation_cutback, yes).
f_domain(synfuels_corporation_cutback, no).

f_domain(mx_missile, yes).
f_domain(mx_missile, no).


% Properties for Categorical Features

	% physician_fee_freeze

		% Pre-intervention world
			not_pre_physician_fee_freeze(X) :- f_domain(physician_fee_freeze, Y),pre_physician_fee_freeze(Y), Y \= X.
			pre_physician_fee_freeze(X):- not not_pre_physician_fee_freeze(X).

		% Post-Intervention world
			not_post_physician_fee_freeze(X) :- f_domain(physician_fee_freeze, Y), post_physician_fee_freeze(Y), Y \= X.
			post_physician_fee_freeze(X):- not not_post_physician_fee_freeze(X).

	% budget_resolution

		% Pre-intervention world
			not_pre_budget_resolution(X) :- f_domain(budget_resolution, Y),pre_budget_resolution(Y), Y \= X.
			pre_budget_resolution(X):- not not_pre_budget_resolution(X).

		% Post-Intervention world
			not_post_budget_resolution(X) :- f_domain(budget_resolution, Y), post_budget_resolution(Y), Y \= X.
			post_budget_resolution(X):- not not_post_budget_resolution(X).

	% handicapped_infants

		% Pre-intervention world
			not_pre_handicapped_infants(X) :- f_domain(handicapped_infants, Y),pre_handicapped_infants(Y), Y \= X.
			pre_handicapped_infants(X):- not not_pre_handicapped_infants(X).

		% Post-Intervention world
			not_post_handicapped_infants(X) :- f_domain(handicapped_infants, Y), post_handicapped_infants(Y), Y \= X.
			post_handicapped_infants(X):- not not_post_handicapped_infants(X).

	% synfuels_corporation_cutback

		% Pre-intervention world
			not_pre_synfuels_corporation_cutback(X) :- f_domain(synfuels_corporation_cutback, Y),pre_synfuels_corporation_cutback(Y), Y \= X.
			pre_synfuels_corporation_cutback(X):- not not_pre_synfuels_corporation_cutback(X).

		% Post-Intervention world
			not_post_synfuels_corporation_cutback(X) :- f_domain(synfuels_corporation_cutback, Y), post_synfuels_corporation_cutback(Y), Y \= X.
			post_synfuels_corporation_cutback(X):- not not_post_synfuels_corporation_cutback(X).

	% mx_missile

		% Pre-intervention world
			not_pre_mx_missile(X) :- f_domain(mx_missile, Y),pre_mx_missile(Y), Y \= X.
			pre_mx_missile(X):- not not_pre_mx_missile(X).

		% Post-Intervention world
			not_post_mx_missile(X) :- f_domain(mx_missile, Y), post_mx_missile(Y), Y \= X.
			post_mx_missile(X):- not not_post_mx_missile(X).





% Decision rule 
	lite_republican(A,B,C,D,E):- A = yes, not ab2(B,C,D,E).
		ab1(B,C):- B = yes , C \= no.
		ab2(B,C,D,E):- D = yes , E \= no, not ab1(B,C).

	#show lite_republican/5, not lite_republican/5.
	#show ab1/2, not ab1/2.
	#show ab2/4, not ab2/4.

	republican(A,B,C,D,E):- f_domain(physician_fee_freeze, A),
		f_domain(budget_resolution, B), f_domain(handicapped_infants, C),
		f_domain(synfuels_corporation_cutback, D), f_domain(mx_missile, E),

		pre_physician_fee_freeze(A), pre_budget_resolution(B), 
		pre_handicapped_infants(C), pre_synfuels_corporation_cutback(D),
		pre_mx_missile(E), 
			
		lite_republican(A,B,C,D,E).

% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	
	cf_republican(A,B,C,D,E):- f_domain(physician_fee_freeze, A),
		f_domain(budget_resolution, B), f_domain(handicapped_infants, C),
		f_domain(synfuels_corporation_cutback, D), f_domain(mx_missile, E),

		post_physician_fee_freeze(A), post_budget_resolution(B), 
		post_handicapped_infants(C), post_synfuels_corporation_cutback(D),
		post_mx_missile(E), 
			
		not lite_republican(A,B,C,D,E).




?-republican(A,B,C,D,E).

%?-republican(yes,yes,no,yes,yes).
%?-republican(A,yes,yes,D,E).

?-cf_republican(A,B,C,D,E).




% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.

% Measure
	f_domain(control,0).
	f_domain(control,1).


	measure(Z1,Z2,Z3,Z4,Z5,X):- f_domain(control,Z1), f_domain(control,Z2),
		f_domain(control,Z3), f_domain(control,Z4),f_domain(control,Z5),
		X #= Z1+Z2+Z3+Z4+Z5.



% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

id_restrict(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1)):- f_domain(physician_fee_freeze, A),
		%f_domain(budget_resolution, B), f_domain(handicapped_infants, C),
		%f_domain(synfuels_corporation_cutback, D), f_domain(mx_missile, E),

		%f_domain(physician_fee_freeze, A1),
		%f_domain(budget_resolution, B1), f_domain(handicapped_infants, C1),
		%f_domain(synfuels_corporation_cutback, D1), f_domain(mx_missile, E1),

	compare_C(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3), 
	compare_C(D,D1,Z4), compare_C(E,E1,Z5).






% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D,E):-f_domain(physician_fee_freeze, A),
		f_domain(budget_resolution, B), f_domain(handicapped_infants, C),
		f_domain(synfuels_corporation_cutback, D), f_domain(mx_missile, E),

		pre_physician_fee_freeze(A), pre_budget_resolution(B), 
		pre_handicapped_infants(C), pre_synfuels_corporation_cutback(D),
		pre_mx_missile(E).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D,E):-f_domain(physician_fee_freeze, A),
		f_domain(budget_resolution, B), f_domain(handicapped_infants, C),
		f_domain(synfuels_corporation_cutback, D), f_domain(mx_missile, E),

		post_physician_fee_freeze(A), post_budget_resolution(B), 
		post_handicapped_infants(C), post_synfuels_corporation_cutback(D),
		post_mx_missile(E).

% Make the craig function Extremely interpretable
refined(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1),X):-
	republican(A,B,C,D,E),
	pre_realistic(A,B,C,D,E),

	cf_republican(A1,B1,C1,D1,E1),
	post_realistic(A1,B1,C1,D1,E1),

	id_restrict(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1)).%, 
	measure(Z1,Z2,Z3,Z4,Z5,X).


?- pre_realistic(A,B,C,D,E).
%?- post_realistic(A,B,C,D,E).
?-id_restrict(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1)).


?-republican(A,B,C,D,E).
?-cf_republican(A,B,C,D,E).
?-refined(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1),X).








