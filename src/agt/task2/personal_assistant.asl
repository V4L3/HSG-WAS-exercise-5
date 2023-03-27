// personal assistant agent 

/* Task 2 Start of your solution */

/* Interference rules */
best_option("vibration") :- ranking_for_vibration(Ranking) & not methodUsed("vibration") & Ranking < ranking_for_artificial_light(Ranking) & Ranking < ranking_for_natural_light(Ranking).
best_option("artificial_light") :- ranking_for_artificial_light(Ranking) & not methodUsed("artificial_light") & Ranking < ranking_for_vibration(Ranking) & Ranking < ranking_for_natural_light(Ranking).
best_option("natural_light") :- ranking_for_natural_light(Ranking) & not methodUsed("natural_light") & Ranking < ranking_for_artificial_light(Ranking) & Ranking < ranking_for_vibration(Ranking).

/* Initial beliefs */
ranking_for_artificial_light(2).
ranking_for_natural_light(1).
ranking_for_vibration(0).

/* Initial goals */

/* Plans */

@start_wake_up_routine
+!start_wake_up_routine : owner_state("asleep") <-
    !wake_up_user;
    !start_wake_up_routine.

@end_wake_up_routine
+!start_wake_up_routine : owner_state("awake") <-
    .print("The wake-up routine has been successfull!");
    -start_wake_up_routine.


@reacto_to_upcomming_event
+upcoming_event(State) : upcoming_event("now") & owner_state("asleep") <-
    .print("Starting wake-up routine");
    !start_wake_up_routine.

@whish_enjoyment_plan
+upcoming_event(State) : upcoming_event("now") & owner_state("awake") <-
    .print("Enjoy your event").

@wakeup_with_vibration_plan
+!wake_up_user : owner_state("asleep") & best_option("vibration") <-
    .print("Setting mattress to vibration mode.");
    +methodUsed("vibration");
    setVibrationsMode.

@wakeup_with_natural_light_plan
+!wake_up_user : owner_state("asleep") & best_option("natural_light") <-
    .print("Raising the blinds.");
    +methodUsed("natural_light");
    raiseBlinds.

@wakeup_with_artificial_light_plan
+!wake_up_user : owner_state("asleep") & best_option("artificial_light") <-
    .print("Turning on the lights.");
    +methodUsed("artificial_light");
    turnOnLights.

@wakeup_plan
+!wake_up_user : owner_state("asleep") <-
    .print("No best option set").

@blinds_plan
+blinds(State) : true <- 
    .print("The blinds are ", State).

@lights_plan
+lights(State) : true <- 
    .print("The lights are ", State).

@mattress_plan
+mattress(State) : true <- 
    .print("The matress is ", State).

@owner_state_plan
+owner_state(State) : true <- 
    .print("The owner is ", State).
/* Task 2 End of your solution */

/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }