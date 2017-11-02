import React from 'react'
import axios from 'axios'
import PropTypes from 'prop-types'
import { FormGroup, FormControl, ControlLabel, Button, HelpBlock } from 'react-bootstrap'

const token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common.Accept = 'application/json'

class Edit extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      title: '',
      description: '',
      titleValidateState: null,
      titleValidateMsg: '',
    }
  }

  componentWillMount() {
    this.setState({
      title: this.props.group.title,
      description: this.props.group.description,
    })
  }

  handleChange = (e) => {
    this.setState({ [e.target.name]: e.target.value })
  };

  handleTitleChange= (e) => {
    this.handleChange(e)
    const length = e.target.value.length
    if (length > 0) {
      this.setState({
        titleValidateState: null,
        titleValidateMsg: '',
      })
    }
  };

  handleSubmit = (e) => {
    e.preventDefault()
    const data = {
      title: this.state.title,
      description: this.state.description,
    }
    axios.put(`/groups/${this.props.group.id}`, { group: data })
      .then((response) => {
        if (response.data.errors) {
          this.setState({
            titleValidateState: 'error',
            titleValidateMsg: response.data.errors[0],
          })
        }
        if (response.status === 200) {
          window.location = '/groups'
        }
      })
  };

  render() {
    return (
      <div className="container-fluid">
        <h2>編輯討論版</h2>
        <hr />

        <form onSubmit={this.handleSubmit}>
          <FormGroup
            controlId="title"
            validationState={this.state.titleValidateState}
          >
            <ControlLabel>Title</ControlLabel>
            <FormControl
              type="text"
              name="title"
              placeholder="Enter title"
              value={this.state.title}
              onChange={this.handleTitleChange}
            />
            <FormControl.Feedback />
            <HelpBlock>{ this.state.titleValidateMsg }</HelpBlock>
          </FormGroup>
          <FormGroup
            controlId="description"
          >
            <ControlLabel>Description</ControlLabel>
            <FormControl
              type="text"
              name="description"
              placeholder="Enter description"
              value={this.state.description}
              onChange={this.handleChange}
            />
            <FormControl.Feedback />
          </FormGroup>
          <Button type="submit" bsStyle="primary">
            Update Group
          </Button>
        </form>
      </div>
    )
  }
}

Edit.defaultProps = {
  group: {},
}

Edit.propTypes = {
  group: PropTypes.shape({
    id: PropTypes.number.isRequired,
    title: PropTypes.string.isRequired,
    description: PropTypes.string,
  }),
}

export default Edit
