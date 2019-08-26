
*Model= AIDS 
*No of Goods= 4
*Demographic variables= none

capture program drop demand-estimate_aids
program nlsuraids_sm_g4_nodemos

	version 10
	
	syntax varlist(min=8 max=8) if, at(name)
	
	tokenize `varlist'
	args bs1 bs2 bs3 lnp1 lnp2 lnp3 lnp4 lnm 
	
	tempname a1 a2 a3 a4
	scalar `a1' = `at'[1,1]	
	scalar `a2' = `at'[1,2]	
	scalar `a3' = `at'[1,3]	
	scalar `a4' = 1 - `a1' - `a2' - `a3' 
	
	tempname b1 b2 b3
	scalar `b1' = `at'[1,4]
	scalar `b2' = `at'[1,5]
	scalar `b3' = `at'[1,6]
	
	tempname t11 t12 t13 
	tempname     t22 t23  
	tempname         t33  
	
	scalar `t11' = `at'[1,7]
	scalar `t12' = `at'[1,8]
	scalar `t13' = `at'[1,9]

	scalar `t22' = `at'[1,10]
	scalar `t23' = `at'[1,11]
	
	scalar `t33' = `at'[1,12]

		
	replace `bs1' = `a1'  + `a1'*(`lnp1' - (`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4' )) ///
					+ `b1'*(`lnm' -    ///
									( (`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4') ///
										- 0.5*(`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4')*(`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4') ///
										+ 0.5*(`a1'*`lnp1'*`lnp1' + `a2'*`lnp2'*`lnp2'    +`a3'*`lnp3'*`lnp3'+ `a4'*`lnp4'*`lnp4' )  ///
										- 0.5*( ///
											   (`t11'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4')) *(`t11'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4'))  +   ///
											   (`t22'*(`lnp2' - `lnp4') + `t23'*(`lnp3' - `lnp4'))*(`t22'*(`lnp2' - `lnp4') + `t23'*(`lnp3' - `lnp4')) +   ///
											   (`t33'*(`lnp3' - `lnp4'))*(`t33'*(`lnp3' - `lnp4')) ///
											   )	///
									)  ///
							)	///	
					- `t11'*(`t11'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4')) 
					
						
	replace `bs2' = `a2'  + `a2'*(`lnp2' - (`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4' ))  ///
					+ `b2'*(`lnm' -  ///
									( (`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4') ///
										- 0.5*(`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4')*(`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4') ///
										+ 0.5*(`a1'*`lnp1'*`lnp1' + `a2'*`lnp2'*`lnp2'    +`a3'*`lnp3'*`lnp3'+ `a4'*`lnp4'*`lnp4' )  ///
										- 0.5*( ///
											   (`t11'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4')) *(`t11'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4'))  +   ///
											   (`t22'*(`lnp2' - `lnp4') + `t23'*(`lnp3' - `lnp4'))*(`t22'*(`lnp2' - `lnp4') + `t23'*(`lnp3' - `lnp4')) +   ///
											   (`t33'*(`lnp3' - `lnp4'))*(`t33'*(`lnp3' - `lnp4')) ///
											   )	///
									)  ///
							)	///					
					- (`t12'*(`t11'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4')) ///
					+  `t22'*(`t22'*(`lnp2' - `lnp4') + `t23'*(`lnp3' - `lnp4')) )
	
	replace `bs3' = `a3'  + `a3'*(`lnp3' - (`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4' ))  ///
					+ `b3'*(`lnm'  - ///
								  ( (`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4') ///
										- 0.5*(`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4')*(`a1'*`lnp1' + `a2'*`lnp2' + `a3'*`lnp3' + `a4'*`lnp4') ///
										+ 0.5*(`a1'*`lnp1'*`lnp1' + `a2'*`lnp2'*`lnp2'    +`a3'*`lnp3'*`lnp3'+ `a4'*`lnp4'*`lnp4' )  ///
										- 0.5*( ///
											   (`t11'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4')) *(`t11'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4'))  +   ///
											   (`t22'*(`lnp2' - `lnp4') + `t23'*(`lnp3' - `lnp4'))*(`t22'*(`lnp2' - `lnp4') + `t23'*(`lnp3' - `lnp4')) +   ///
											   (`t33'*(`lnp3' - `lnp4'))*(`t33'*(`lnp3' - `lnp4')) ///
											   )	///
									)  ///
							)	///					
					- (`t13'*(`lnp1' - `lnp4') + `t12'*(`lnp2' - `lnp4') + `t13'*(`lnp3' - `lnp4') ///
					   +`t23'*(`t22'*(`lnp2' - `lnp4') + `t23'*(`lnp3' - `lnp4'))  ///
					   +`t33'*(`t33'*(`lnp3' - `lnp4')) )
	
	
	
end
