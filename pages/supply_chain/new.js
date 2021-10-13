import React , { Component } from 'react';
import Layout from '../../components/Layout';
import { Form, Input, Message, Button } from 'semantic-ui-react';
import supplyChainFactoryInstance from '../../ethereum/supplyChainFactoryInstance';
import { Router } from '../../routes';

class SupplyChainNew extends React.Component {

	state = {
		supplyChainTitle : '',
		errorMessage: '',
		loading: false
	};

	onSubmit = async( event) => {

		event.preventDefault();

		if( window.ethereum ){
			/*
				OPEN METAMASK AND ASSIGN TO METAMASK CONNECTED ACCOUNT
			*/	
			const connected_account = await window.ethereum.request({ method: 'eth_requestAccounts' });

			try{
				this.setState({ loading : true, errorMessage:'' });

				await supplyChainFactoryInstance.methods
							.createSupplyChain( this.state.supplyChainTitle )
							.send({ 
								from: connected_account[0],
								chainId: 3
							});	

				Router.pushRoute('/');

			}catch(err){
				
				// console.log(err.message);
				this.setState({errorMessage: err.message});
			}
			this.setState({ loading : false });
		}
	}

	render() {

		return (
			<Layout>
				<h3>Create a Supply Chain</h3>	
				<Form onSubmit={ this.onSubmit } error={!!this.state.errorMessage}>
					<Form.Field>
				      	<label>Supply Chain Title</label>
				      	<Input 
				      		label="Title" 
							labelPosition="right"
							value={ this.state.supplyChainTitle } 
							onChange={ event => this.setState( { supplyChainTitle : event.target.value} ) }
				      	/>
				    </Form.Field>
				    <Message
				    	error
			          	header='Error'
			          	content={ this.state.errorMessage }
			        />
			        <Button loading={ this.state.loading } primary>Create</Button>
			  	</Form>
			</Layout>
		);
	}

}
export default SupplyChainNew;